require "net/http"
require "json"

puts "Starting ShopSmart data import..."

# Fetch products from DummyJSON API
url = URI("https://dummyjson.com/products?limit=200")

response = Net::HTTP.get_response(url)

unless response.is_a?(Net::HTTPSuccess)
  abort "API request failed: #{response.code}"
end

data = JSON.parse(response.body)

products = data["products"]

puts "Found #{products.length} products"

products.each do |item|

  # Create brand
  brand_name = item["brand"].to_s.strip
  brand_name = "Generic" if brand_name.empty?

  brand = Brand.find_or_create_by!(name: brand_name) do |b|
    b.description = "Products manufactured by #{brand_name}"
  end

  # Create category
  category_name = item["category"].to_s.strip
  category_name = "Other" if category_name.empty?

  category = Category.find_or_create_by!(name: category_name) do |c|
    c.description = "Products in the #{category_name} category"
  end

  # Create product
  product = Product.find_or_initialize_by(
    name: item["title"]
  )

  product.description = item["description"].presence || "No description available"
  product.price = item["price"]
  product.image_url = item["thumbnail"]
  product.stock_quantity = item["stock"] || 0
  product.brand = brand

  product.save!

  # Connect product with category
  ProductCategory.find_or_create_by!(
    product: product,
    category: category
  )

  # Add tags
  tags = item["tags"] || []

  tags.each do |tag_name|

    tag = Tag.find_or_create_by!(name: tag_name)

    ProductTag.find_or_create_by!(
      product: product,
      tag: tag
    )

  end

end

puts "Data import completed!"

puts "Brands: #{Brand.count}"
puts "Categories: #{Category.count}"
puts "Products: #{Product.count}"
puts "Tags: #{Tag.count}"
puts "Total records: #{Brand.count + Category.count + Product.count + Tag.count + ProductCategory.count + ProductTag.count}"