require './lib/aviatrix_data'

class Aviatrix
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
    @running
  end

  def max_fuel
    5000
  end

  def refuel
    fuel_needed = max_fuel - fuel_level
    fuel_price = AviatrixData.fuel_prices[location]
    cost = fuel_needed * fuel_price
    @fuel_cost += cost
    @fuel_level = max_fuel
    {
      :quantity => fuel_needed,
      :unit_price => fuel_price,
      :spent => cost
    }
  end

  def fly_to(destination)
    @distance_traveled += distance_to(destination)
    @fuel_level -= distance_to(destination) / miles_per_gallon
    @location = destination
  end

  def distance_to(target)
    AviatrixData.known_distances[location][target]
  end

  def known_destinations
    AviatrixData.location_names.keys
  end

  def location_names
    AviatrixData.location_names
  end

  def name_for(location_marker)
    location_names[location_marker]
  end

  def starting_location
    :st_louis
  end

  def location_name
    AviatrixData.location_names[location]
  end
end
