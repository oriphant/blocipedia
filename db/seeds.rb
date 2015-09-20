# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

# Create Users
users = User.all
10.times do
  user = User.new(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10), 
    role: 'basic'
    )
    user.skip_confirmation!
    user.save!
end

# Create Wikis
wikis=Wiki.all
50.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    user: users.sample,
    )
end

# Create an admin user
admin = User.new(
  name: 'Admin Man',
  email: 'admin@example.com',
  password: 'helloworld',
  role: 'admin'
  )
admin.skip_confirmation!
admin.save!

# Create an premium user
premium = User.new(
  name: 'Premium Man',
  email: 'premium@example.com',
  password: 'helloworld',
  role: 'premium'
  )
premium.skip_confirmation!
premium.save!

# Create an regular user
regular = User.new(
  name: 'Regular Man',
  email: 'regular@example.com',
  password: 'helloworld',
  role: 'basic'
  )
regular.skip_confirmation!
regular.save!

 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Wiki.count} wikis created"
