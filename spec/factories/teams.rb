# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do |team|
    team.sequence(:name) { |n| Faker::Lorem.word.titleize + " Group" + " #{n}" }
    team.hospital
    team.user

    before(:create) do
      team.hospital = FactoryGirl.create(:hospital) unless team.hospital.present?
      team.user = FactoryGirl.create(:user) unless team.user.present?
    end
  end
end
