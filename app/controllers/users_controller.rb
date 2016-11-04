class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def destinations
    if current_user
      @destinations = current_user.destinations
    end
  end

end
