class Api::V1::BirdsController < ApplicationController

  def index
    birds = Bird.visible
    if birds.blank?
      show_invalid_response(false, [], "No data found")
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
    rescue Mongoid::Errors::Validations, StandardError => e
      show_invalid_response(false, [], e.message)
    end
  end

  def show
    bird = Bird.find(params[:id])
    if bird.nil?
      show_invalid_response(false, [], "No data found")
    else
      render json: bird
    end
  end

  def destroy
    bird = Bird.find(params[:id])
    if bird.nil?
      show_invalid_response(false, [], "No data found")
    else
      bird.destroy
      render json: {}
    end
  end

  private
  def bird_attrs
    params.require(:birds).permit(:name, :family, :added, :visible, :continents => [])
  end

end
