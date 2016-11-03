class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def my_destinations
    @my_destinations = @user.destinations
  end

end
