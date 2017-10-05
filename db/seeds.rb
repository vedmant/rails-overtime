# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create! (
  email: 'test@test.com',
  password: '123456',
  first_name: 'John',
  last_name: 'Snow',
  phone: '123123')

puts '1 User has been created'

admin_user = AdminUser.create! (
  email: 'admin@test.com',
  password: '123456',
  first_name: 'Jordan',
  last_name: 'Hudgens',
  phone: '123123')

puts '1 AdminUser has been created'

100.times do |post|1
  Post.create date: Date.today, rationale: "#{post} rationale content", user: user, overtime_request: 2.5
end

puts '100 Posts have been created'

