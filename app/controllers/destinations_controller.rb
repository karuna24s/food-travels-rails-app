class DestinationsController < ApplicationController
  def index
    @destinations = Destination.all
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @destinations }
    end
  end

  def show
    @destination = Destination.find(params[:id])
    @food = @destination.food
    if current_user
      @comment = current_user.comments.build(destination: @destination)
    end
    respond_to do |format|
      format.html { render :show }
      format.json { render json:  @destination }
    end
  end

  def next_destination
    @destination = Destination.find(params[:id])
    @next_destination = @destination.next
    render json: @next_destination
  end

  def previous_destination
    @destination = Destination.find(params[:id])
    @previous_destination = @destination.previous
    render json: @previous_destination
  end

  def new
    @destination ||= Destination.new
    @destination.build_food
  end

  def create
    @destination = current_user.destinations.new(destination_params)

    if @destination.save
      redirect_to destination_path(@destination)
    else
      redirect_to new_destination_path, alert: "You must add a title, content and location in order to create a story."
    end
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

  # def destination_indexes
  #   respond_to do |format|
  #     format.html { render :show }
  #     format.json { render json: Destination.all.map{|dest| dest.id}}
  #   end
  # end

  private

  def destination_params
    params.require(:destination).permit(:title, :location, :content, :recommendation, :food_id, :food_attributes => [:name, :category])
  end

end
