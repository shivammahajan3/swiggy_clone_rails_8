class UsersController < ApplicationController

  def show
  end

  def edit_name
  end

  def update_name
    # debugger
    if current_user.update(params.expect(user: [:name]))
      flash[:notice] = "Name has been updated!"
    else
      flash[:alert] = "Something went wrong!"
    end
    redirect_to current_user
  end 

  def edit_address
  end
  
  def update_address
    if current_user.update(params.expect(user: [:address]))
      flash[:notice] = "Address has been updated!"
    else
      flash[:alert] = "Something went wrong!"
    end
    redirect_to current_user
  end

  def edit_phone_number
  end

  def update_phone_number
    if current_user.update(params.expect(user: [:phone_number]))
      flash[:notice] = "Phone Number has been updated!"
    else
      flash[:alert] = "Something went wrong!"
    end
    redirect_to current_user
  end

end