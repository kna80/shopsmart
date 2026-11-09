class Product < ApplicationRecord
  belongs_to :brand

  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
end