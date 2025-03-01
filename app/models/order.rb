class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restro
  has_many :order_products
  has_many :products, through: :order_products
  enum :status, [ :pending, :accepted, :rejected, :delivered ]
end
