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

    factory :team_with_members do
      after(:create) do |tm|
        FactoryGirl.create(:membership, user: FactoryGirl.create(:user), team: tm )
        FactoryGirl.create(:membership, user: FactoryGirl.create(:user), team: tm )
        tm.members.each do |m|
          FactoryGirl.create(:designation, user: m, hospital: tm.hospital)
        end
      end
    end
  end
end
