# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |user|
    user.name { Faker::Name.name }
    user.email { Faker::Internet.email }
    user.sequence(:password) {|n| "test_pwd#{n}"}
    user.sequence(:password_confirmation) {|n| "test_pwd#{n}"}

   # has_many association is not working with factory girl. So recreate with methods
   # while testing
   #
   # factory :user_with_client do
   #   after(:create) do
   #     create(:client, user: user)
   #   end
   # end
  end
end
