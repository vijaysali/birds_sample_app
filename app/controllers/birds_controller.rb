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
    bird = Bird.find(params[:id])
    if bird.nil?
      render json: {data: "No value found"}
    else
      render json: bird
    end
  end

  def destroy
    bird = Bird.find(params[:id])
    if bird.nil?
      render json: {data: "no value found"}
    else
      bird.destroy
      render json: {}
    end
  end

  private
  def bird_attrs
    params.require(:birds).permit(:name, :family, :added, :visible, :continents => [])
  end

  def required(params, *lst)
    blanks = lst - lst.reject {|x| params[x] == "" or params[x].nil? }
    if blanks.empty?
      parameters = lst.map {|x| params[x] }
      parameters.count == 1 ? parameters.first : parameters
    else
      raise "Fields cannot be empty #{blanks}"
    end
  end


end
