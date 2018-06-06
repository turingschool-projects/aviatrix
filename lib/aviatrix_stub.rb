require './lib/aviatrix_data'

class AviatrixStub
  attr_reader :location, :distance_traveled, :fuel_level,
              :miles_per_gallon, :fuel_cost, :odometer

  def initialize
    @running = false
    @location = starting_location
    @fuel_level = max_fuel
    @miles_per_gallon = 0.5
    @fuel_cost = 0
    @distance_traveled = 0
  end

  def author
    "None"
  end

  def start
    @running = true
  end

  def running?
    @running
  end

  def max_fuel
    0 #stub
  end

  def fuel_full?
    true #stub
  end

  def refuel
    {
      :quantity => 0,   #stub
      :unit_price => 0, #stub
      :spent => 0       #stub
    }
  end

  def fuel_price(location_a)
    0 #stub
  end

  def fuel_prices
    AviatrixData.fuel_prices
  end

  def fly_to(destination)
    true #stub
  end

  def fuel_to_fly(location_a, location_b)
    0 #stub
  end

  def distance_between(location_a, location_b)
    0 #stub
  end

  def known_distances
    {:st_louis => {:st_louis => 0} } #stub
  end

  def valid_destination?(target)
    true #stub
  end

  def location_names
    ["St. Louis"] #stub
  end

  def name_for(location_marker)
    "St. Louis" #stub
  end

  def starting_location
    :st_louis
  end

  def location_name
    "St. Louis" #stub
  end
end
