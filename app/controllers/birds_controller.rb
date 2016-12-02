class BirdsController < ApplicationController

  def index
    birds = Bird.visible

    render json: birds, each_serializer: BirdSerializer
  end

  def create
  end

  def show
  end

  def destroy
  end

end
