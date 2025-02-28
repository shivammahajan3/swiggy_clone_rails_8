class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :restros
  has_many :orders
  enum :role, [ :user, :restro_user, :delivery_partner, :admin ]
end
