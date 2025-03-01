class Product < ApplicationRecord
  belongs_to :restro
  has_many :order_products
  has_many :orders, through: :order_products
  has_one_attached :prod_profile
end
