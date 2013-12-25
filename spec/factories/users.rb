# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |user|
    user.name { Faker::Name.name }
    user.email { Faker::Internet.email }
    user.password "test_pwd"
    user.password_confirmation "test_pwd"

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
