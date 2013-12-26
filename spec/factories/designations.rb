# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :designation do |designation|
    designation.name { Faker::Name.title.split(" ")[2] }
    designation.user
    designation.hospital
    designation.aasm_state "inactive"

    before(:create) do
      designation.user = FactoryGirl.create(:user) unless designation.user.present?
      designation.hospital = FactoryGirl.create(:hospital) unless designation.hospital.present?
    end

  end
end
