require './lib/aviatrix_data'

class AviatrixStub
  attr_reader :location, :distance_traveled, :fuel_level,
              :miles_per_gallon, :fuel_cost, :odometer

  def initialize
    @running = false
    @location = starting_location
    @fuel_level = max_fuel
    @miles_per_gallon = 0.4
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
    true #stub
  end

  def max_fuel
    0 #stub
  end

  def refuel
    {
      :quantity => 0,   #stub
      :unit_price => 0, #stub
      :spent => 0       #stub
    }
  end

  def fly_to(destination)
    true #stub
  end

  def distance_to(target)
    0 #stub
  end

  def known_destinations
    [:st_louis] #stub
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

  def fuel_check
    if fuel_level < 0
      puts ""
      puts "🔥 " * 24
      puts "Oh no! You've run out of fuel and crashed on the way to #{name_for(location)}!"
      puts "🔥 " * 24
      `say oh no!`
      exit
    else
      true
    end
  end
end
