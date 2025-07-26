class User < ApplicationRecord
  include Versioning

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :restros
  has_many :orders
  has_one_attached :profile
  enum :role, [ :customer, :restro_user, :delivery_partner, :admin ]
end
