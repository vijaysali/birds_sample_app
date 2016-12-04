class Api::V1::BirdsController < ApplicationController
  # CRUD- operations for bird model.
  def index
    birds = Bird.visible
    if birds.blank?
      show_invalid_response(message: "No data found", status: 404)
    else
      render json: birds, each_serializer: BirdSerializer
    end
  end

  def create
    begin
      required(params[:birds], :name, :family, :continents)

      bird_object = Bird.new(bird_attrs)
      bird_object.save!
      render json: bird_object
    rescue Mongoid::Errors::Validations
      show_invalid_response(message: e.message, status: 412)
    rescue StandardError => e
      show_invalid_response(message: e.message, status: 404)
    end
  end

  def show
    begin
      bird = Bird.find(params[:id])
      render json: bird
    rescue StandardError => e
      show_invalid_response(message: e.message, status: 404)
    end
  end

  def destroy
    begin
      bird = Bird.find(params[:id])
      bird.destroy
      render json: {}
    rescue StandardError => e
      show_invalid_response(message: e.message, status: 404)
    end
  end

  private
  def bird_attrs
    params.require(:birds).permit(:name, :family, :added, :visible, :continents => [])
  end

end
