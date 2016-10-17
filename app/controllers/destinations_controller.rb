class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
  end

  def show
    @destination = Destination.find(params[:id])
  end

  def new
    @destination = Destination.new
    @destination.build_food #belongs_to adds build assoications
  end

  def create

    # raise params.inspect
    @destination = Destination.create(destination_params)
    redirect_to destination_path(@destination)
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    @destination.update(destination_params)
    redirect_to destination_path(@destination)
  end

  private

  def destination_params
    params.require(:destination).permit(:title, :location, :content, :recommendation, :food_id, :user_id, :food_attributes => [:name, :category])
  end

end
