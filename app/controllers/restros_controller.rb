class RestrosController < ApplicationController
  
  before_action :require_restro_user, only: [:new, :create]

  def index
    if !user_signed_in? || current_user.customer?
      @restros = Restro.all
    elsif current_user.restro_user?
      redirect_to restro_owner_path
    end
  end

  def show
    @restro = Restro.find(params[:id])
    if !user_signed_in? || current_user.customer?
      @products = @restro.products
    elsif current_user == @restro.user
      @products = @restro.products
    else
      flash[:alert] = "You can't see other's restaurents"
      redirect_to restro_owner_path
    end
  end

  def restro_owner
    @restros = current_user.restros
  end

  def new
    @restro = Restro.new
  end

  def create
    @restro = Restro.new(restro_params)
    @restro.user = current_user
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

  def require_restro_user
    unless current_user.restro_user?
      flash[:alert] = "You can't access this option!"
      redirect_to restros_path
    end
  end

end
