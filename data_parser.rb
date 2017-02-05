#!/usr/bin/env ruby

# Explorer Mode

require 'csv'

class Delivery
  attr_accessor :destination, :what_got_shipped, :number_of_crates, :money_we_made

  def initialize(destination, what_got_shipped, number_of_crates, money_we_made) # read more on named parameters
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
end # End of Delivery class

class Parse
  # attr_accessor :deliveries     # Removed for class methods

# I'm pretty shaky on why all of these have to be class methods instead of instance methods?

  def self.parse_data(file_name)
    delivery_sheet = CSV.foreach(file_name, headers: true, header_converters: :symbol)
    delivery_sheet.collect do |row|
      Delivery.new(row[:destination], row[:what_got_shipped], row[:number_of_crates], row[:money_we_made])
    end
  end

  def self.pilot_names(deliveries)
    deliveries.collect(&:pilot).uniq    # This and all other instances changed in to procs when I beautified. I'm not this smart.
  end

  def self.total(deliveries)
    deliveries.collect(&:money_we_made).inject(:+)
  end

  def self.total_by_pilot(deliveries, pilot)
    deliveries.select { |delivery| delivery.pilot == pilot }
              .collect(&:money_we_made).inject(:+)
  end

  def self.bonus(deliveries, pilot_name)
    deliveries.select { |delivery| delivery.pilot == pilot_name }
              .collect(&:money_we_made)
              .inject(:+) * 0.1
  end

  def self.pilot_trips(deliveries, pilot)
    deliveries.select { |delivery| delivery.pilot == pilot }.count
  end

  def self.money_by_planet(deliveries, planet)
    deliveries.select { |delivery| delivery.destination == planet }
              .collect(&:money_we_made)
              .inject(:+)
  end
end # End of Parse class



file_name = ARGV[0]
action_wanted = ARGV[1]
deliveries = Parse.parse_data(file_name)

puts "We made $#{Parse.total(deliveries)} this week."

puts "Fry's bonus is $#{Parse.bonus(deliveries, 'Fry')}."
puts "Amy's bonus is $#{Parse.bonus(deliveries, 'Amy')}."
puts "Bender's bonus is $#{Parse.bonus(deliveries, 'Bender')}."
puts "Leela's bonus is $#{Parse.bonus(deliveries, 'Leela')}."

puts "Amy piloted #{Parse.pilot_trips(deliveries, 'Amy')} trips."
puts "Bender piloted #{Parse.pilot_trips(deliveries, 'Bender')} trips."
puts "Fry piloted #{Parse.pilot_trips(deliveries, 'Fry')} trips."
puts "Leela piloted #{Parse.pilot_trips(deliveries, 'Leela')} trips."

deliveries.collect(&:destination).uniq
          .each { |planet| puts "We made $#{Parse.money_by_planet(deliveries, planet)} from deliveries to #{planet}." }



if action_wanted == 'report'
  CSV.open('payroll.csv', 'w') do |csv|
    csv << ['Pilot', 'Shipments', 'Total Revenue', 'Payment']
    Parse.pilot_names(deliveries).each do |pilot|
      csv << [pilot, Parse.pilot_trips(deliveries, pilot), Parse.total_by_pilot(deliveries, pilot), Parse.bonus(deliveries, pilot)]
    end
  end
  puts 'New file created.'
end





# total = 0
# deliveries.each { |delivery| total += delivery.money_we_made }
# puts total
#
# total = deliveries.collect { |delivery| delivery.money_we_made }.inject(:+)   # Another way to calculate total

# amy_bonus = 0
# bender_bonus = 0
# fry_bonus = 0
# leela_bonus = 0
#
# deliveries.each do |delivery|
#   case delivery.pilot
#   when 'Fry' then fry_bonus += (delivery.money_we_made * 0.1)
#   when 'Amy' then amy_bonus += (delivery.money_we_made * 0.1)
#   when 'Bender' then bender_bonus += (delivery.money_we_made * 0.1)
#   when 'Leela' then leela_bonus += (delivery.money_we_made * 0.1)
#   end
#   end
#
# puts "Fry's bonus is $#{fry_bonus}."
# puts "Amy's bonus is $#{amy_bonus}."
# puts "Bender's bonus is $#{bender_bonus}."
# puts "Leela's bonus is $#{leela_bonus}."
#
#
# # deliveries.each do |delivery|           # Finding bonus without pilot method from above
# #   case delivery.destination
# #   when "Earth" then fry_bonus += (delivery.money_we_made.to_i * 0.1)
#
#
# # How many trips did each employee pilot?
#
# amy_trips = deliveries.select { |delivery| delivery.pilot == 'Amy' }.count
# bender_trips = deliveries.select { |delivery| delivery.pilot == 'Bender' }.count
# fry_trips = deliveries.select { |delivery| delivery.pilot == 'Fry' }.count
# leela_trips = deliveries.select { |delivery| delivery.pilot == 'Leela' }.count
#
# puts "Amy piloted #{amy_trips} trips."
# puts "Bender piloted #{bender_trips} trips."
# puts "Fry piloted #{fry_trips} trips."
# puts "Leela piloted #{leela_trips} trips."
#
# # deliveries.each do |delivery|         # Not using pilot method from above
# #   case delivery.destination
# #   when "Mars" then amy_trips += 1
# #
# #
# # leela_trips = deliveries.select { |delivery| delivery.destination != "Mars" && delivery.destination != "Earth" && delivery.destination != "Uranus" }.count            # Not using pilot method from above
#
#
#
# # Adventure Mode
# # Define a class "Parse", with a method parse_data, with an argument file_name that handles output to the console
# # How much money did we make broken down by planet? ie. how much did we make shipping to Earth? Mars? Saturn? etc.
#
#
# planets = %w(Earth Moon Mars Uranus Jupiter Pluto Saturn Mercury)
#
# planets.each do |planet|
#   total = deliveries.select { |delivery| delivery.destination == planet }
#                     .collect { |delivery| delivery.money_we_made }
#                     .inject { |sum, moolah| sum + moolah }
#   puts "Planet Express made $#{total} from deliveries to #{planet}."
#   end
# end
