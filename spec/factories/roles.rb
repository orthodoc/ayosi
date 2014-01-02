FactoryGirl.define do
  factory :role do |role|
    role.name { Faker::Name.title.split(" ")[2] }
  end
end
