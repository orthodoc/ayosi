# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :patient do
    name "MyString"
    birth_date "2013-12-08"
    age ""
    gender "MyString"
    hospital nil
  end
end
