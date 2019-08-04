# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
user = User.first or raise "Must Create a User First"
categories = Category.create!([{ name: 'Electronics' }, { name: 'Art' }, { name: 'Car Stuff'}, { name: 'Toys'}, { name: 'Appliances'}, { name: 'Sports'}])
categories.each do |category|
  Prod.create!([
    {name: Faker::Commerce.product_name, description: Faker::Marketing.buzzwords, cost: Faker::Commerce.price, category_id: category.id, user_id: user.id}, 
    {name: Faker::Commerce.product_name, description: Faker::Marketing.buzzwords, cost: Faker::Commerce.price, category_id: category.id, user_id: user.id}, 
    {name: Faker::Commerce.product_name, description: Faker::Marketing.buzzwords, cost: Faker::Commerce.price, category_id: category.id, user_id: user.id} 
  ])
end
