class SearchesController < ApplicationController

  def index
    type = params[:type]
    search = params[:search]

    if search.present? && type == 'restaurants' || current_user&.customer?
      @restros = Restro.where('name LIKE ?', "%#{search}%")
    elsif search.present? && type == 'restaurants' && current_user.restro_user?
      @restros = current_user.restros.where('name LIKE ?', "%#{search}%")
    else
      @restros = []
    end

    if search.present? && type == 'dishes'
      @products = Product.where('name LIKE ?', "%#{search}%")
    else
      @products = []     
    end
    
  end

end