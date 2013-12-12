# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :surgery do |surgery|
    surgery.name { Faker::Lorem.word.titleize + " Procedure" }
    surgery.sequence(:date) {|n| ("#{n+100}").to_i.days.ago }
    surgery.patient
    surgery.hospital

    before(:create) do
      surgery.patient = FactoryGirl.create(:patient) unless surgery.patient.present?
      surgery.hospital = FactoryGirl.create(:hospital) unless surgery.hospital.present?
    end
  end
end
