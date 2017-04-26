# data_parser
Day 4 assignment

Good news Rubyists!
We have a week of records tracking what we shipped at Planet Express. I need you to answer a few questions for Hermes.

- How much money did we make this week?
- How much of a bonus did each employee get? (bonuses are paid to employees who pilot the Planet Express)
- How many trips did each employee pilot?
- Define and use your Delivery class to represent each shipment
- Different employees have favorite destinations they always pilot to

Fry - pilots to Earth (because he isn't allowed into space)
Amy - pilots to Mars (so she can visit her family)
Bender - pilots to Uranus (teeheee...)
Leela - pilots everywhere else because she is the only responsible one

- They get a bonus of 10% of the money for the shipment as the bonus

Adventure Mode
- Define a class "Parse", with a method parse_data, with an argument file_name that handles output to the console
- How much money did we make broken down by planet? ie. how much did we make shipping to Earth? Mars? Saturn? etc.

Epic Mode
- No puts or print's in any method
- No methods longer than 10 lines long
- Make data_parser.rb executable with a command line argument of the file name
./data_parser.rb planet_express_logs.csv

Legendary Mode
- All the above questions should have corresponding class methods in Parse
- If the script is called with a report argument (as in: ./data_parser.rb planet_express_logs.csv report), the script saves a new CSV file in the current directory with payroll information in the format of: Pilot, Shipments, Total Revenue, Payment
