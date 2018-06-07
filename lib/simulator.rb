require './lib/aviatrix'

def puts_slow(message)
  puts ""
  puts message
  sleep 1
end

def puts_fast(message)
  puts message
  sleep 0.3
end

def gauges(plane)
  puts_slow "Reading the gauges..."
  puts ""
  puts_fast "| Running:   | #{plane.running? ? '✅' : '❌'}"
  puts_fast "| Location:  | #{plane.location_name}"
  puts_fast "| Fuel:      | #{'%.2f' % plane.fuel_level} gallons"
  puts_fast "| Max Fuel:  | #{plane.max_fuel} gallons"
  puts_fast "| MPG:       | #{plane.miles_per_gallon}"
  puts_fast "| Fuel Bill: | $#{'%.2f' % plane.fuel_cost}"
  puts_fast "| Distance:  | #{plane.distance_traveled} miles"
end

def fly(plane)
  puts_slow "Where would you like to fly to?"
  puts ""

  destinations = plane.known_destinations
  destinations.each.with_index do |marker, index|
    city_name = plane.name_for(marker)
    distance = plane.distance_to(marker)
    puts_fast "#{index}) #{city_name} (#{distance} miles)"
  end

  puts ""
  print "Destination Number: "
  raw_input = gets.chomp.strip
  number = raw_input.to_i

  if (raw_input == number.to_s) && (0...destinations.count).include?(number)
    puts_slow "🛫 Preparing for takeoff..."
    puts_slow "Flying..."
    plane.fly_to(destinations[number])
    fuel_check(plane)
    puts_slow "🛬 You've arrived in #{plane.location_name}!"
    gauges(plane)
  else
    puts_slow "Sorry, that's not a valid destination."
  end
end

def refuel(plane)
  puts_slow "Refueling..."
  refuel_data = plane.refuel
  puts_slow "⛽ Here in #{plane.location_name}, jet fuel costs $#{refuel_data[:unit_price]}/gallon"
  puts_slow "⛽ You refueled #{refuel_data[:quantity]} gallons totaling $#{'%.2f' % refuel_data[:spent]}"
end

def fuel_check(plane)
  if plane.fuel_level < 0
    puts ""
    puts "🔥 " * 24
    puts "Oh no! You've run out of fuel and crashed on the way to #{plane.location_name}!"
    puts "🔥 " * 24
    `say oh no!`
    exit
  else
    true
  end
end

av = Aviatrix.new
puts_slow "Welcome to the Aviatrix Flight System by #{av.author}"

av.start
puts_slow "You're currently in #{av.location_name}"

command = ""

until command == "q"
  puts ""
  puts "What would you like to do?"
  puts "a) 📊 check the plane gauges"
  puts "b) 🛫 fly to a different city"
  puts "c) ⛽ refuel"
  puts "q) ❌ quit"
  puts ""
  print "Action: "
  command = gets.chomp.strip

  if command == "a"
    gauges(av)
  elsif command == "b"
    fly(av)
  elsif command == "c"
    refuel(av)
  elsif command != "q"
    puts_slow "I don't recognize this command: [#{command.inspect}]"
  end
end

puts ""
puts "Thanks for playing!"
