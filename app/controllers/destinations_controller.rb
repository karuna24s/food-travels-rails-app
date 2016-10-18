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
    @destination.build_food #belongs_to adds build assoications
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
    @destination = Destination.find(params[:id])
    @destination.update(destination_params)
    redirect_to destination_path(@destination)
  end

  def destroy
    @destination = Destination.find_by(id: params[:id])
    if @destination.destroy
      flash[:success] = "Food Travel Story is destroyed"
    else
      flash[:danger] = "Food Travel Story is not destroyed"
    end
    redirect_to root_url
  end

  private

  def destination_params
    params.require(:destination).permit(:title, :location, :content, :recommendation, :food_id, :food_attributes => [:name, :category])
  end

end
