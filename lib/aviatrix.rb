class Aviatrix
  attr_reader :location

  def initialize
    @running = true
    @location = starting_location
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

  def command(input)
    case input
    when "quit" then stop
    end
  end

  def fly_to(destination)
    if valid_destination?(destination)
      @location = destination
    end
  end

  def valid_destination?(target)
    location_names.keys.include?(target)
  end

  def location_names
    {
      :st_louis => "St. Louis",
      :phoenix => "Phoenix",
      :denver => "Denver",
      :slc => "Salt Lake City",
      :nyc => "New York City"
    }
  end

  def starting_location
    :st_louis
  end

  def location_name
    location_names[location]
  end
end
