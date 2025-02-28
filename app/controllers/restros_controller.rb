class RestrosController < ApplicationController
  
  def index
    @restros = Restro.all
  end

end
