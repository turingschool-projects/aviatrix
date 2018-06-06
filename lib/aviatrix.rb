require './lib/aviatrix_data'

class Aviatrix
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

  def start
    @running = true
  end

  def stop
    @running = false
  end

  def running?
    @running
  end

  def max_fuel
    4000
  end

  def fuel_full?
    fuel_level == max_fuel
  end

  def refuel
    fuel_needed = max_fuel - fuel_level
    cost = (fuel_needed * fuel_price(location)).round(2)
    @fuel_cost += cost
    @fuel_level = max_fuel
    {
      :quantity => fuel_needed,
      :unit_price => fuel_price(location),
      :spent => cost
    }
  end

  def fuel_price(location_a)
    fuel_prices[location_a]
  end

  def fuel_prices
    AviatrixData.fuel_prices
  end

  def fly_to(destination)
    if running? && valid_destination?(destination)
      @distance_traveled += distance_between(location, destination)
      @fuel_level -= fuel_to_fly(location, destination)
      @location = destination

      if fuel_level < 0
        raise "Oh no! You've run out of fuel and crashed on the way to #{name_for(destination)}!"
      end
    end
  end

  def fuel_to_fly(location_a, location_b)
    (distance_between(location_a, location_b).to_f / miles_per_gallon)
  end

  def distance_between(location_a, location_b)
    begin
      known_distances[location_a][location_b]
    rescue NoMethodError => e
      raise("Distance Unknown: #{location_a.inspect} to #{location_b.inspect}")
    end
  end

  def known_distances
    AviatrixData.known_distances
  end

  def valid_destination?(target)
    location_names.keys.include?(target)
  end

  def location_names
    AviatrixData.location_names
  end

  def name_for(location_marker)
    location_names[location_marker]
  end

  def starting_location
    AviatrixData.location_names.keys.first
  end

  def location_name
    name_for(location)
  end
end
