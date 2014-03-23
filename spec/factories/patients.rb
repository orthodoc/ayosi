# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :patient do |patient|
    patient.sequence(:name) { |n| Faker::Name.name.concat(" #{n}") }
    patient.sequence(:age) {|n| ("#{n+30}").to_i}
    patient.sequence(:birthday) {|n| ("#{n+30}").to_i.years.ago }
    patient.gender {["Male", "Female", "Others"].sample}

   # has_many association is not working with factory girl. So recreate with methods
   # while testing
   #
   # factory :patient_with_surgery do
   #   after(:create) do
   #     create(:surgery, patient: patient)
   #   end
   # end
   #
   # factory :patient_with_client do
   #   after(:create) do
   #     create(:client, patient: patient)
   #   end
   # end

  end
end
