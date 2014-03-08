FactoryGirl.define do
  factory :role do |role|
    role.name { Faker::Company.position.split(" ")[-1] }
  end
end
