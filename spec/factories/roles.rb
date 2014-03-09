FactoryGirl.define do
  factory :role do |role|
    role.sequence(:name) { |n| Faker::Company.position.split(" ")[-1].concat(" #{n}") }
  end
end
