class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
  end

  def show
    @destination = Destination.find(params[:id])
    @food = @destination.food
  end

  def new
    @destination = Destination.new
    @destination.build_food #belongs_to adds build associations
  end

  def create
    # raise params.inspect
    @destination = current_user.destinations.create(destination_params)
    redirect_to destination_path(@destination)
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    if !current_user
      redirect_to new_user_session_path, alert: "You must be logged in order to edit a travel story"
    elsif current_user.username == params[:user_id]
      @destination = Destination.find(params[:id])
      @destination.update(destination_params)
      redirect_to destination_path(@destination)
    else
      redirect_to new_user_destination_path(current_user), alert: "You can only edit travel stories for yourself"
    end

  end

  def destroy
    if current_user
      @destination.destroy
      redirect_to destinations_path
    else
      redirect_to new_user_session_path, alert: "You must be logged in order to delete a travel story"
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:title, :location, :content, :recommendation, :food_id, :food_attributes => [:name, :category])
  end

end
