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

food = Category.create(name: 'Food')
home = Category.create(name: 'Home Improvement')
cleaning = Category.create(name: 'Cleaning')
gardening = Category.create(name: 'Gardening')
clothing = Category.create(name: 'Clothing')
other = Category.create(name: 'Other')

user = User.create(first_name: 'Carole', last_name: 'Baskin', email: 'carole@tigers.com', password: 'password', zip: 80206)
user1 = User.create(first_name: 'Joe', last_name: 'Exotic', email: 'joe4president@gmail.com', password: 'password', zip: 80206)


posting = Posting.create(posting_type: 0, title: "Seeking food supplies")
posting1 = Posting.create(posting_type: 0, title: "Seeking home improvement tools")
posting2 = Posting.create(posting_type: 0, title: "In need of home goods yo")

posting3 = Posting.create(posting_type: 1, title: "Lending spare items from my garage")
posting4 = Posting.create(posting_type: 1, title: "Lending some food supplies")

chips = food.items.create(name: 'chips', quantity: 1, measurement: 'bag', available: true, returnable: false, user_id: user1.id, posting_id: posting1.id, description: "Looking for ruffles, but will settle for cheetos.")
cheese = food.items.create(name: 'cheese', quantity: 4, measurement: "cups", available: true, returnable: false, user_id: user.id, posting_id: posting.id, description: "I need cheese." )

eggs = food.items.create(name: 'eggs', quantity: 1, measurement: 'dozen', available: true, returnable: false, user_id: user1.id, posting_id: posting4.id, description: "May I offer you a nice egg in this this trying time?")
butter = food.items.create(name: 'butter', quantity: 8, measurement: "oz", available: true, returnable: false, user_id: user.id, posting_id: posting4.id, description: "I can't believe it's butter. I'm a vegan." )
milk = food.items.create(name: 'milk', quantity: 1, measurement: "gallon", available: true, returnable: false, user_id: user.id, posting_id: posting4.id, description: "My cow Leche produces too much milk.")
drill = home.items.create(name: 'cordless drill', quantity: 1, time_duration: 'hours', available: true, returnable: true, user_id: user.id, posting_id: posting3.id, description: "Make your husband regret all those times he said 'I don't have time for a home project'.")
mop = cleaning.items.create(name: 'mop', quantity: 1, time_duration: 'day', available: true, returnable: true, user_id: user.id, posting_id: posting3.id, description: "Spunky is in love with this.")
trowel = gardening.items.create(name: 'trowel', quantity: 3, time_duration: 'weeks', available: true, returnable: true, user_id: user.id, posting_id: posting3.id, description: "Make those hoes jealous.")
gloves = gardening.items.create(name: 'gloves', quantity: 5, time_duration: 'days', available: true, returnable: true, description: 'Ever since my friend OJ borrowed these gloves, I have been missing just one.', user_id: user.id, posting_id: posting3.id)
jacket = clothing.items.create(name: 'jacket', quantity: 4, time_duration: 'days', available: true, returnable: true, user_id: user.id, posting_id: posting3.id, description: "Good for taking your scooter for a spin.")
