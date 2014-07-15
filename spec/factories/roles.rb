FactoryGirl.define do
  factory :role do |role|
    rol.name { Faker::Company.position.split(" ")[-1] }
    # role.sequence(:name) { |n| Faker::Company.position.split(" ")[-1].concat(" #{n}") }
  end
end
