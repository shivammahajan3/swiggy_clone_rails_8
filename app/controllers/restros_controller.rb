class RestrosController < ApplicationController
  
  def index
    @restros = Restro.all
  end

  def show
    @restro = Restro.find(params[:id])
    @products = @restro.products
  end

  def new
    @restro = Restro.new
  end

  def create
    @restro = Restro.new(restro_params)
    @restro.user = User.first
    if @restro.save
      flash[:notice] = "Resturent added Successfully"
      redirect_to restros_path
    else
      flash[:alert] = "Something went wrong!"
      render :new, status: 422
    end
  end

  private

  def restro_params
    params.expect(restro: [ :name, :address, :phone_number, :res_profile])
  end

end
