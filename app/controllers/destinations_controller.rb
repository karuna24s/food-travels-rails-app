class DestinationsController < ApplicationController
  def index
    @destinations = Destinations.all
  end

  def show
  end

end
