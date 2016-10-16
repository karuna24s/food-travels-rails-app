class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def show
    binding.pry
    @food = Food.find(params[:id])
  end

  def new
    @food = Food.new
  end

  def create
    # raise params.inspect
    @food = Food.create(food_params)
    redirect_to food_path(@food)
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    @food.update(food_params)
    redirect_to food_path(@food)
  end

  private

  def food_params
    params.require(:food).permit(:name, :category, destinations_attributes: [:title, :content, :location, :recommendation])
  end
end
