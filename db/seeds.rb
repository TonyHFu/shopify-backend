# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Product.destroy_all

Product.create!(
	name: Faker::ElectricalComponents.active,
	description: Faker::Device.serial,
	quantity: 20,
	price: 15.99,
)

Product.create!(
	name: Faker::ElectricalComponents.active,
	description: Faker::Device.serial,
	quantity: 20,
	price: 25.99,
)

Product.create!(
	name: Faker::ElectricalComponents.active,
	description: Faker::Device.serial,
	quantity: 20,
	price: 5.99,
)

Product.create!(
	name: Faker::ElectricalComponents.active,
	description: Faker::Device.serial,
	quantity: 20,
	price: 12.99,
)

Product.create!(
	name: Faker::ElectricalComponents.active,
	description: Faker::Device.serial,
	quantity: 20,
	price: 89.99,
)
