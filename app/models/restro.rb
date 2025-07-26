class Restro < ApplicationRecord
  include Versioning

  belongs_to :user
  has_many :products
  has_many :orders
  has_one_attached :res_profile
  
end
