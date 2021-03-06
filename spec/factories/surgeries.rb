# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :surgery do |surgery|
    surgery.procedure { Faker::Lorem.word + " Procedure" }
    # surgery.sequence(:procedure) { |n| Faker::Lorem.word + " Procedure" + " #{n}" }
    surgery.sequence(:date) {|n| ("#{n+100}").to_i.days.ago }
    surgery.patient
    surgery.hospital
    surgery.sequence(:uhid) {|n| "UHID #{n+1000}"}
    surgery.category {["Primary", "Revision"].sample}
    surgery.side {["Right", "Left"].sample}
    surgery.region {["Hip","Knee","Shoulder"].sample}
    surgery.surgeon { Faker::Name.name }
    # surgery.sequence(:surgeon) { |n| Faker::Name.name.concat(" #{n}") }
    surgery.diagnosis {["Primary OA", "Secondary OA", "AVN"].sample}
    # surgery.sequence(:diagnosis) { |n| "Primary OA" + " #{n}"}

    before(:create) do
      surgery.patient = FactoryGirl.create(:patient) unless surgery.patient.present?
      surgery.hospital = FactoryGirl.create(:hospital) unless surgery.hospital.present?
    end
  end
end
