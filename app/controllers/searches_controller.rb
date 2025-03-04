class SearchesController < ApplicationController

  def index
    type = params[:type]
    search = params[:search]

    if search.present? && type == 'restaurants'
      if current_user&.customer?
        @restros = Restro.where('name LIKE ?', "%#{search}%")
      elsif current_user.restro_user?
        @restros = current_user.restros.where('name LIKE ?', "%#{search}%")
      end
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