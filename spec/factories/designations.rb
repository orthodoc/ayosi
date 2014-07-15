# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :designation do |designation|
    designation.name { Faker::Company.position.titleize }
    # designation.sequence(:name) { |n| Faker::Company.position.titleize.concat(" #{n}") }
    designation.user
    designation.hospital
    designation.is_default false

    before(:create) do
      designation.user = FactoryGirl.create(:user) unless designation.user.present?
      designation.hospital = FactoryGirl.create(:hospital) unless designation.hospital.present?
    end

  end
end
