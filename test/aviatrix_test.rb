require 'minitest/autorun'
require './lib/aviatrix'

class AviatrixTest < Minitest::Test

  def test_it_starts_and_stops
    av = Aviatrix.new
    av.start
    assert av.running?
    av.command("quit")
    refute av.running?
  end

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

  def test_it_does_not_fly_to_unknown_destination
    av = Aviatrix.new
    av.start

    refute av.valid_destination?(:tampa)
    assert av.location == av.starting_location

    refute av.fly_to(:tampa)
    assert av.location == av.starting_location
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

  def test_all_distances_are_defined
    av = Aviatrix.new

    locations = av.location_names.keys
    locations.each do |current|
      locations.each do |target|
        assert av.distance_between(current, target)
      end
    end
  end
end
