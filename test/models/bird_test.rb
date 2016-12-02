require 'test_helper'

class BirdTest < ActiveSupport::TestCase

  def setup
    @continents = ["Africa", "Antarctica", "Asia", "Australia", "Europe", "North America", "South America"]
    @families   = ["Kingfishers", "Woodpeckers", "Creepers", "Mockingbirds", "Finches", "Flamingos"]
  end

  def teardown
    Bird.destroy_all
  end

  # proper case
  def test_create_bird
    input_value = {name: "test_bird", continents: @continents.sample(2), family: @families.sample}
    bird = Bird.new(input_value)

    assert_equal true, bird.save!
    assert_equal false, bird.visible
    input_value.map do |attr_name, attr_value|
      assert_equal attr_value, bird.send(attr_name)
    end
  end

end
