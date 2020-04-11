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

butter = food.items.create(name: 'butter', quantity: 8, measurement: "oz", available: true, returnable: false, user_id: user.id )
milk = food.items.create(name: 'milk', quantity: 1, measurement: "gallon", available: true, returnable: false, user_id: user.id)
cheese = food.items.create(name: 'cheese', quantity: 4, measurement: "cups", available: true, returnable: false, user_id: user.id )

drill = home.items.create(name: 'cordless drill', quantity: 1, time_duration: 'hours', available: true, returnable: true, user_id: user.id)

mop = cleaning.items.create(name: 'mop', quantity: 1, time_duration: 'day', available: true, returnable: true, user_id: user.id)

trowel = gardening.items.create(name: 'trowel', quantity: 3, time_duration: 'weeks', available: true, returnable: true, user_id: user.id)
gloves = gardening.items.create(name: 'gloves', quantity: 5, time_duration: 'days', available: true, returnable: true, description: 'Ever since my friend OJ borrowed these gloves, I have been missing just one.', user_id: user.id)

jacket = clothing.items.create(name: 'jacket', quantity: 4, time_duration: 'days', available: true, returnable: true, user_id: user.id)

Posting.create(item_id: butter.id, posting_type: 0)
Posting.create(item_id: milk.id, posting_type: 0)
Posting.create(item_id: cheese.id, posting_type: 0)
Posting.create(item_id: drill.id, posting_type: 0)
Posting.create(item_id: mop.id, posting_type: 0)
Posting.create(item_id: trowel.id, posting_type: 0)
Posting.create(item_id: gloves.id, posting_type: 0)
Posting.create(item_id: jacket.id, posting_type: 0)
Posting.create(item_id: butter.id, posting_type: 1)
Posting.create(item_id: milk.id, posting_type: 1)
Posting.create(item_id: cheese.id, posting_type: 1)
Posting.create(item_id: drill.id, posting_type: 1)
Posting.create(item_id: mop.id, posting_type: 1)
Posting.create(item_id: trowel.id, posting_type: 1)
Posting.create(item_id: gloves.id, posting_type: 1)
Posting.create(item_id: jacket.id, posting_type: 1)
