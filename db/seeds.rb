# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'SETTING UP DEFAULT Manager LOGIN'
user = User.create! :username => "admin", :fullname => 'Admin', :email => 'angmeng@gmail.com', :password => '123456', :password_confirmation => '123456', :category_id => 1
puts 'New User created: ' << user.fullname

puts 'SETTING UP DEFAULT Staff LOGIN'
user = User.create! :username => "staff", :fullname => 'Staff', :email => 'staff@gmail.com', :password => '123456', :password_confirmation => '123456', :category_id => 2
puts 'New User created: ' << user.fullname

puts 'SETTING UP DEFAULT Agent LOGIN'
user = User.create! :username => "agent", :fullname => 'Agent', :email => 'agent@gmail.com', :password => '123456', :password_confirmation => '123456', :category_id => 3
puts 'New User created: ' << user.fullname

puts 'SETTING UP DEFAULT User LOGIN'
user = User.create! :username => "user", :fullname => 'User', :email => 'user@gmail.com', :password => '123456', :password_confirmation => '123456', :category_id => 4
puts 'New User created: ' << user.fullname

puts 'SETTING UP DEFAULT Company'
company = Company.create! :name => "Ferry Sdn Bhd", :register_number => 'PP123456789', :email => 'company@gmail.com', :address_1 => '123456', :address_2 => '123456', :phone => "123456", :fax => "123456"
puts 'New Company created: ' << company.name