class Order < ApplicationRecord
  include Versioning

  belongs_to :user
  belongs_to :restro
  belongs_to :delivery_partner, class_name: 'User', optional: true
  has_many :order_products
  has_many :products, through: :order_products
  enum :status, [ :pending, :accepted, :rejected, :completed, :shipping, :delivered ]
end
