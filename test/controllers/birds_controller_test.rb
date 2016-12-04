require 'test_helper'

class Api::V1::BirdsControllerTest < ActionController::TestCase

  def setup
    @continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
    @families   = ["Kingfishers", "Woodpeckers", "Creepers", "Mockingbirds", "Finches", "Flamingos"]
  end

  def json
    ActiveSupport::JSON.decode @response.body
  end

  def status_code
    @response.status
  end

  def teardown
    Bird.destroy_all
  end

  def test_index
    get "index"

    assert_equal "No data found", json["message"]
    assert_equal 404, status_code
    input_value = [
      {name: "test_bird", continents: @continents.sample(2), family: @families.sample, visible: true},
      {name: "test_bird1", continents: @continents.sample(2), family: @families.sample, visible: true},
      {name: "test_bird2", continents: @continents.sample(2), family: @families.sample},
      {name: "test_bird3", continents: @continents.sample(2), family: @families.sample},
    ]
    bird = Bird.create(input_value)

    get "index"
    assert_equal 200, status_code
    assert_equal 2, json.count
  end

  def test_show
    input_value = {name: "test_bird", continents: @continents.sample(2), family: @families.sample, visible: true}
    bird        = Bird.create(input_value)
    get "show", id: bird.id

    assert_equal 200, status_code
    output_value = { name: json["name"], continents: json["continents"], family: json["family"], visible: json["visible"] }
    assert_equal input_value, output_value
  end

  def test_destroy
    input_value = {name: "test_bird", continents: @continents.sample(2), family: @families.sample, visible: true}
    bird        = Bird.create(input_value)
    get "show", id: bird.id

    output_value = { name: json["name"], continents: json["continents"], family: json["family"], visible: json["visible"] }
    assert_equal input_value, output_value
    assert_equal 200, status_code

    delete "destroy", id: bird.id
    assert_equal 0, Bird.all.count
    assert_equal 200, status_code
  end

  def test_create
    post "create", {birds: {name: "test_bird", family: @families.sample, continents: @continents.sample(3), visible: true}}

    assert_equal 200, status_code
    assert_equal 1, Bird.count
  end

  def test_create_negative
    post "create", {birds: {name: "test_bird" }}
    assert_equal 0, Bird.count
  end

end
