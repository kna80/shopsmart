class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :image_url
      t.integer :stock_quantity
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
