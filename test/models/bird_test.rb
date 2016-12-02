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

  # Introduce new fields apart from declared in models
  # should raise exception
  def test_create_unknown_attributes
    input_value = {name: "test_bird", continents: @continents.sample(2), family: @families.sample, x: 1, y: 2}
    assert_raises Mongoid::Errors::UnknownAttribute do
      bird = Bird.new(input_value)
      assert_equal true, bird.save!
    end
  end

  def test_check_name_uniqueness
    input_value = {name: "test_bird", continents: @continents.sample(2), family: @families.sample}
    bird = Bird.new(input_value)

    assert_equal true, bird.save!
    assert_equal false, bird.visible

    bird1 = Bird.new(input_value)
    assert_raises Mongoid::Errors::Validations do
      bird1.save!
    end
  end

end
