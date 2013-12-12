# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :client do |client|
    client.user
    client.patient

    before(:create) do
      client.user = FactoryGirl.create(:user) unless client.user.present?
      client.patient = FactoryGirl.create(:patient) unless client.patient.present?
    end
  end
end
