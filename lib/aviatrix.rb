class Aviatrix
  attr_reader :location, :distance_traveled, :fuel_level, :miles_per_gallon, :fuel_cost

  def initialize
    @running = false
    @location = starting_location
    @fuel_level = max_fuel
    @miles_per_gallon = 0.5
    @fuel_cost = 0
  end

  def start
    @running = true
    @distance_traveled = 0
  end

  def stop
    @running = false
  end

  def running?
    @running
  end

  def max_fuel
    1000
  end

  def fuel_full?
    fuel_level == max_fuel
  end

  def refuel
    fuel_needed = max_fuel - fuel_level
    @fuel_cost += fuel_needed * fuel_price(location)
    @fuel_level = max_fuel
  end

  def fuel_price(location_a)
    fuel_prices[location_a]
  end

  def fuel_prices
    {
      :st_louis => 179,
      :phoenix => 184,
      :denver => 165,
      :slc => 195
    }
  end

  def fly_to(destination)
    if running? && valid_destination?(destination)
      @distance_traveled += distance_between(location, destination)
      @fuel_level -= fuel_to_fly(location, destination)
      @location = destination
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
    {
      :st_louis =>
        {
          :st_louis => 0,
          :phoenix  => 1,
          :denver   => 2,
          :slc      => 3
        },
      :phoenix =>
        {
          :st_louis => 1,
          :phoenix  => 0,
          :denver   => 2,
          :slc      => 3
        },
      :denver =>
        {
          :st_louis => 1,
          :phoenix  => 2,
          :denver   => 0,
          :slc      => 3
        },
      :slc =>
        {
          :st_louis => 1,
          :phoenix  => 2,
          :denver   => 3,
          :slc      => 0
        }
    }
  end

  def valid_destination?(target)
    location_names.keys.include?(target)
  end

  def location_names
    {
      :st_louis => "St. Louis",
      :phoenix => "Phoenix",
      :denver => "Denver",
      :slc => "Salt Lake City"
    }
  end

  def starting_location
    :st_louis
  end

  def location_name
    location_names[location]
  end
end
