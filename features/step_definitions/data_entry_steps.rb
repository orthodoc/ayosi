## UTILITY METHODS ##

def create_user
  @user = FactoryGirl.create(@user)
end

## GIVENS ##

Given(/^I am on the data entry page$/) do
  visit new_patient_path
end
## WHENS ##
## THENS ##
Then(/^I should see the name of the hospital$/) do
  page.should have_content(@user.hospital.name)
end

Then(/^I should see the name of the city$/) do
  page.should have_content(@user.hospital.city)
end
