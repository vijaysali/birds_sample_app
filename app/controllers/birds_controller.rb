class BirdsController < ApplicationController

  def index
    birds = Bird.visible

    render json: birds, each_serializer: BirdSerializer
  end

  def create
    begin
      required(params[:birds], :name, :family, :continents)

      bird_object = Bird.new(bird_attrs)
      bird_object.save!
      render json: bird_object
    rescue StandardError => e
      render json: {data: e.message}
    end
  end

  def show
  end

  def destroy
  end

end
