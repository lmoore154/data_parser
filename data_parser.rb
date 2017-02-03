#!/usr/bin/env ruby

# Explorer Mode

require 'pry'
require 'csv'


class Delivery
  attr_accessor :destination, :what_got_shipped, :number_of_crates, :money_we_made

  def initialize(destination, what_got_shipped, number_of_crates, money_we_made)  # read more on named parameters
    @destination = destination
    @what_got_shipped = what_got_shipped
    @number_of_crates = number_of_crates
    @money_we_made = money_we_made.to_i
  end


  def pilot
    case destination
    when 'Earth' then 'Fry'
    when 'Mars' then 'Amy'
    when 'Uranus' then 'Bender'
    else 'Leela'
    end
  end
end


class Parse
attr_accessor :deliveries
  def parse_data(file_name)
    delivery_sheet = CSV.foreach('planet_express_logs.csv', headers: true, header_converters: :symbol)
    @deliveries = []
    delivery_sheet.each do |row|
      @deliveries << Delivery.new(row[:destination], row[:what_got_shipped], row[:number_of_crates], row[:money_we_made])
  end


total = 0
deliveries.each { |delivery| total += delivery.money_we_made }
puts total

# total = deliveries.collect { |delivery| delivery.money_we_made }.inject(:+)   # Another way to calculate total


amy_bonus = 0
bender_bonus = 0
fry_bonus = 0
leela_bonus = 0

deliveries.each do |delivery|
  case delivery.pilot
  when 'Fry' then fry_bonus += (delivery.money_we_made * 0.1)
  when 'Amy' then amy_bonus += (delivery.money_we_made * 0.1)
  when 'Bender' then bender_bonus += (delivery.money_we_made * 0.1)
  when 'Leela' then leela_bonus += (delivery.money_we_made * 0.1)
  end
  end

puts "Fry's bonus is $#{fry_bonus}."
puts "Amy's bonus is $#{amy_bonus}."
puts "Bender's bonus is $#{bender_bonus}."
puts "Leela's bonus is $#{leela_bonus}."

# deliveries.each do |delivery|           # Finding bonus without pilot method from above
#   case delivery.destination
#   when "Earth" then fry_bonus += (delivery.money_we_made.to_i * 0.1)


# How many trips did each employee pilot?

amy_trips = deliveries.select { |delivery| delivery.pilot == 'Amy' }.count
bender_trips = deliveries.select { |delivery| delivery.pilot == 'Bender' }.count
fry_trips = deliveries.select { |delivery| delivery.pilot == 'Fry' }.count
leela_trips = deliveries.select { |delivery| delivery.pilot == 'Leela' }.count

puts "Amy piloted #{amy_trips} trips."
puts "Bender piloted #{bender_trips} trips."
puts "Fry piloted #{fry_trips} trips."
puts "Leela piloted #{leela_trips} trips."

# deliveries.each do |delivery|         # Not using pilot method from above
#   case delivery.destination
#   when "Mars" then amy_trips += 1
#
#
# leela_trips = deliveries.select { |delivery| delivery.destination != "Mars" && delivery.destination != "Earth" && delivery.destination != "Uranus" }.count            # Not using pilot method from above



# Adventure Mode
# Define a class "Parse", with a method parse_data, with an argument file_name that handles output to the console
# How much money did we make broken down by planet? ie. how much did we make shipping to Earth? Mars? Saturn? etc.


planets = %w(Earth Moon Mars Uranus Jupiter Pluto Saturn Mercury)

planets.each do |planet|
  total = deliveries.select { |delivery| delivery.destination == planet }
                    .collect { |delivery| delivery.money_we_made }
                    .inject { |sum, moolah| sum + moolah }
  puts "Planet Express made $#{total} from deliveries to #{planet}."
  end
  end


end



# Bonus code extracted to method


def bonus(pilot_name)
  pilot_bonus = deliveries.select { |delivery| delivery.pilot == pilot_name }
                          .collect { |delivery| delivery.money_we_made }
                          .inject { |sum, moolah| sum + moolah } * 0.1
end


def pilot_trips(pilot)
  number_of_trips = deliveries.select { |delivery| delivery.pilot == pilot }.count
end

def


# calcs = Parse.new
# calcs.parse_data("filename")
# puts "Fry's bonus is #{calcs.bonus("Fry")}"   # Look into finding a way to loop over pilots (like the planets array above)
