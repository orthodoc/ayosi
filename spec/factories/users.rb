# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |user|
    user.sequence(:name) {|n| "Test User #{n}"}
    user.sequence(:email) {|n| "test_user#{n}@example.com"}
    user.sequence(:password) {|n| "test_pwd#{n}"}
    user.sequence(:password_confirmation) {|n| "test_pwd#{n}"}

    factory :user_with_hospitals do
      after(:create) do |user|
        FactoryGirl.crate(:hospital, user: user)
      end
    end
  end
end
