# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.destroy_all
Item.destroy_all


food = Category.create(name: 'Food')
home = Category.create(name: 'Home Improvement')
cleaning = Category.create(name: 'Cleaning')
gardening = Category.create(name: 'Gardening')
clothing = Category.create(name: 'Clothing')
other = Category.create(name: 'Other')

food.items.create(name: 'butter', quantity: 8, measurements: "oz", avaliable?: true )
food.items.create(name: 'milk', quantity: 1, measurements: "gallon", avaliable?: true )
food.items.create(name: 'cheese', quantity: 4, measurements: "cups", avaliable?: true )
home.items.create(name: 'cordless drill', quantity: 1, time_duration: 'hours', avaliable?: true)
cleaning.items.create(name: 'mop', quantity: 1, time_duration: 'day', avaliable?: true)
gardening.items.create(name: 'trowel', quantity: 3, time_duration: 'weeks', avaliable?: true)
gardening.items.create(name: 'gloves', quantity: 5, time_duration: 'days', avaliable?: true, description: 'Ever since my friend OJ borrowed these gloves, I have been missing just one.')
clothing.items.create(name: 'jacket', quantity: 4, time_duration: 'days', avaliable?: true)
