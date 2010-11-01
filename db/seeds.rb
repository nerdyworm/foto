# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

admin = User.new({ 
    :email                  => 'ben@test.com', 
    :password               => 'password', 
    :password_confirmation  => 'password'})
admin.save

10.times do |i|
  User.create({
    :email                  => 'test_#{i}@test.com', 
    :password               => 'password', 
    :password_confirmation  => 'password'}).save
end