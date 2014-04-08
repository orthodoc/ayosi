# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hospital do |hospital|
    hospital.sequence(:name) { |n| Faker::Lorem.words(2).join(" ") + " Hospital #{n}" }
    hospital.sequence(:city) { |n| Faker::Address.city.concat(" #{n}") }

   # has_many association is not working with factory girl. So recreate with methods
   # while testing
   #factory :hospital_with_surgery do
   #  after(:create) do
   #    create(:surgery, hospital: hospital)
   #  end
   #end

  end
end
