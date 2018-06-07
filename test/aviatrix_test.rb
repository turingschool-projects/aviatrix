require 'minitest/autorun'
require './lib/aviatrix'

class AviatrixTest < Minitest::Test

  def test_it_starts_in_st_louis
    av = Aviatrix.new
    av.start
    assert_equal "St. Louis", av.location_name
  end

  def test_it_flys_to_phoenix
    av = Aviatrix.new
    av.start
    av.fly_to(:phoenix)
    assert_equal "Phoenix", av.location_name
  end

  def test_it_tracks_distance_traveled
    av = Aviatrix.new
    av.start

    assert_equal 0, av.distance_traveled

    assert av.fly_to(:denver)
    refute_equal 0, av.distance_traveled
  end

  def test_it_accumulates_distance_traveled
    av = Aviatrix.new
    av.start

    assert av.fly_to(:denver)
    first_total = av.distance_traveled

    assert av.fly_to(:st_louis)
    second_total = av.distance_traveled

    assert second_total > first_total
  end

  def test_it_has_a_fuel_level
    av = Aviatrix.new
    av.start

    initial_fuel = av.fuel_level
    av.fly_to(:phoenix)
    final_fuel = av.fuel_level

    assert final_fuel < initial_fuel
  end

  def test_it_refuels
    av = Aviatrix.new
    av.start

    assert av.fuel_level == av.max_fuel

    av.fly_to(:phoenix)
    refute av.fuel_level == av.max_fuel

    av.refuel

    assert av.fuel_level == av.max_fuel
  end

  def test_fuel_costs_money
    av = Aviatrix.new
    av.start

    assert_equal 0, av.fuel_cost

    av.fly_to(:phoenix)
    av.refuel

    assert av.fuel_cost > 1
  end

end
