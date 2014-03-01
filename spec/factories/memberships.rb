# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do |membership|
    membership.user
    membership.team
    membership.aasm_state "inactive"

    before(:create) do
      membership.user = FactoryGirl.create(:user, category: "hospital_staff") unless membership.user.present?
      membership.team = FactoryGirl.create(:team) unless membership.team.present?
    end
  end
end
