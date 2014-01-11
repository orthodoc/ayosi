# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do |team|
    team.name { Faker::Lorem.word.titleize + " Group" }
    team.hospital

    before(:create) do
      team.hospital = FactoryGirl.create(:hospital) unless team.hospital.present?
    end
  end
end
