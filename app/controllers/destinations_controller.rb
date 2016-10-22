class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
  end

  def show
    @destination = Destination.find(params[:id])
    @food = @destination.food
    if current_user
      @comment = current_user.comments.build(destination: @destination)
    end
  end

  def new
    @destination = Destination.new
    @destination.build_food
  end

  def create
    @destination = current_user.destinations.create(destination_params)
    redirect_to destination_path(@destination)
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if !current_user
      redirect_to new_user_session_path, alert: "You must be the author in order to edit a story."
    elsif current_user != @destination.user
      redirect_to :back, alert: "You must be the author in order to edit a story."
    else
      @destination.update(destination_params)
      redirect_to destination_path(@destination)
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    if !current_user
      redirect_to new_user_session_path, alert: "You must be the author in order to delete a story."
    elsif current_user != @destination.user
      redirect_to :back, alert: "You must be the author in order to delete a story."
    else
      @destination.destroy
      redirect_to destinations_path
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:title, :location, :content, :recommendation, :food_id, :food_attributes => [:name, :category])
  end

end
