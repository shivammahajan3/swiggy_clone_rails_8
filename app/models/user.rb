class User < ApplicationRecord
  has_many :restros
  has_many :orders
  enum :role, [ :user, :restro_user, :delivery_partner, :admin ]
end
