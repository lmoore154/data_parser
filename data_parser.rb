# Explorer Mode
#
# Good news Rubyists!
# We have a week of records tracking what we shipped at Planet Express. I need you to answer a few questions for Hermes.
#
# How much money did we make this week?
# How much of a bonus did each employee get? (bonuses are paid to employees who pilot the Planet Express)
# How many trips did each employee pilot?
# Define and use your Delivery class to represent each shipment
# Different employees have favorite destinations they always pilot to
#
# Fry - pilots to Earth (because he isn't allowed into space)
# Amy - pilots to Mars (so she can visit her family)
# Bender - pilots to Uranus (teeheee...)
# Leela - pilots everywhere else because she is the only responsible one
# They get a bonus of 10% of the money for the shipment as the bonus
#
require 'pry'
require 'csv'


class Delivery

  attr_accessor :destination, :item, :crates, :money

  def initialize()
    @destination = destination
    @item = item
    @crates = crates
    @money = money
  end

  def money_made

  end

  def bonus

  end

  def number_of_trips

  end

end

deliveries = []
deliveries << CSV.foreach("planet_express_logs.csv", headers: true, header_converters:
:symbol) do |row|
  puts Delivery.new(row)
end

binding.pry
