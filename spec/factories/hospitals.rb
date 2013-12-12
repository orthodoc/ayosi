# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :hospital do |hospital|
    hospital.name { Faker::Lorem.words(2).join(" ").titleize + " Hospital"}
    hospital.city { Faker::Address.city }

   factory :hospital_with_surgery do
     after(:create) do
       create(:surgery, hospital: hospital)
     end
   end

  end
end
