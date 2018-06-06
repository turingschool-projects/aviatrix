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
end
