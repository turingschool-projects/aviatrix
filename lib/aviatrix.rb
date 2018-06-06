class Aviatrix
  attr_reader :location, :distance_traveled

  def initialize
    @running = true
    @location = starting_location
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

  def command(input)
    case input
    when "quit" then stop
    end
  end

  def fly_to(destination)
    if valid_destination?(destination)
      @distance_traveled += distance_between(location, destination)
      @location = destination
    end
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
