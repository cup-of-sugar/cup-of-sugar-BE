# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all
Item.destroy_all
User.destroy_all
Posting.destroy_all
Message.destroy_all

food = Category.create(name: 'Food')
home = Category.create(name: 'Home Improvement')
cleaning = Category.create(name: 'Cleaning')
gardening = Category.create(name: 'Gardening')
clothing = Category.create(name: 'Clothing')
other = Category.create(name: 'Other')

user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
user1 = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4president@gmail.com', password: 'password', zip: 80206)
user2 = User.create(first_name: 'Harry', last_name: 'Potter', email: 'theboywholived@gmail.com', password: 'expelliarmus', zip: 80203)
user3 = User.create(first_name: 'Hermione', last_name: 'Granger', email: 'thecleverwitch@gmail.com', password: 'expelled', zip: 80202)

message = Message.create(title: 'Borrowing your mop', body: 'Thanks for letting me borrow your mop. Can I come get it tomorrow?', sender_id: user.id, recipient_id: user3.id)
message1 = Message.create(title: 'Borrowing your drill', body: 'Thanks for letting me borrow your drill!! Can you bring it over on Saturday?', sender_id: user1.id, recipient_id: user2.id)
message2 = Message.create(title: 'Checking in', body: "You've marked that you want to borrow my trowel but haven't set up time for to pick it up. Are you still interested?", sender_id: user2.id, recipient_id: user3.id )
message3 = Message.create(title: 'Picking up eggs', body: 'Thanks for giving me some eggs! So excited to make cookies', sender_id: user3.id, recipient_id: user.id)

posting = Posting.create(posting_type: 0, title: "Seeking food supplies", poster_id: user.id, responder_id: user2.id)
posting1 = Posting.create(posting_type: 0, title: "Seeking home improvement tools", poster_id: user2.id)
posting2 = Posting.create(posting_type: 0, title: "In need of home goods yo", poster_id: user3.id)

posting3 = Posting.create(posting_type: 1, title: "Lending spare items from my garage", poster_id: user2.id, responder_id: user3.id)
posting4 = Posting.create(posting_type: 1, title: "Lending some food supplies", poster_id: user1.id, responder_id: user.id)

food.items.create(name: 'chips', quantity: 1, measurement: 'bag', available: true, returnable: false, posting_id: posting1.id, description: "Looking for ruffles, but will settle for cheetos.")
food.items.create(name: 'cheese', quantity: 4, measurement: "cups", available: false, returnable: false, posting_id: posting.id, description: "I need cheese." )

food.items.create(name: 'eggs', quantity: 1, measurement: 'dozen', available: true, returnable: false, posting_id: posting4.id, description: "May I offer you a nice egg in this this trying time?")
food.items.create(name: 'butter', quantity: 8, measurement: "oz", available: true, returnable: false, posting_id: posting4.id, description: "I can't believe it's butter. I'm a vegan." )
food.items.create(name: 'milk', quantity: 1, measurement: "gallon", available: true, returnable: false, posting_id: posting4.id, description: "My cow Leche produces too much milk.")

home.items.create(name: 'cordless drill', quantity: 1, time_duration: 'hours', available: true, returnable: true, posting_id: posting3.id, description: "Make your husband regret all those times he said 'I don't have time for a home project'.")

cleaning.items.create(name: 'mop', quantity: 1, time_duration: 'day', available: true, returnable: true, posting_id: posting3.id, description: "Spunky is in love with this.")

gardening.items.create(name: 'trowel', quantity: 3, time_duration: 'weeks', available: true, returnable: true, posting_id: posting3.id, description: "Make those hoes jealous.")
gardening.items.create(name: 'gloves', quantity: 5, time_duration: 'days', available: true, returnable: true, description: 'Ever since my friend OJ borrowed these gloves, I have been missing just one.', posting_id: posting3.id)

clothing.items.create(name: 'jacket', quantity: 4, time_duration: 'days', available: true, returnable: true, posting_id: posting3.id, description: "Good for taking your scooter for a spin.")
