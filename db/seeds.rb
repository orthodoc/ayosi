# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
user.add_role :admin
doctor = FactoryGirl.create(:user, email: "bdbaruah@ayosi.org", password: "bdb20133", password_confirmation: "bdb20133", category: "hospital_staff")
nurse = FactoryGirl.create(:user, email: "justin@ayosi.org", password: "justin2013", password_confirmation: "justin2013", category: "hospital_staff")
secretary = FactoryGirl.create(:user, email:"tamizh@ayosi.org", password: "tamizh2013", password_confirmation: "tamizh2013", category: "hospital_staff")
data_op = FactoryGirl.create(:user, email: "abbas@ayosi.org", password: "abbas2013", password_confirmation: "abbas2013", category: "hospital_staff")
manager = FactoryGirl.create(:user, email: "mohan@ayosi.org", password: "mohan2013", password_confirmation: "mohan2013", category: "hospital_staff")
physio = FactoryGirl.create(:user, email: "srivatsan@ayosi.org", password: "sri20133", password_confirmation: "sri20133", category: "hospital_staff")
puts "Users created: #{doctor.name},#{nurse.name},#{secretary.name}, #{data_op.name}, #{manager.name}, #{physio.name}"
FactoryGirl.create_list(:hospital, 5)
