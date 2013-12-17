## UTILITY METHODS ##

def create_user
  @user = FactoryGirl.create(:user)
end

def sign_in
  visit new_user_session_path
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_on 'Sign in'
end

def create_hospital
  @hospital = FactoryGirl.create(:hospital)
end

def create_designation
  @designation = FactoryGirl.create(:designation)
end

def create_user_at_hospital_with_designation
  create_user
  create_hospital
  @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
  sign_in
  @hospital = @user.designations.first.hospital
end

def build_patient
  @patient = FactoryGirl.build(:patient)
end

## GIVENS ##

Given(/^I am on the data entry page$/) do
  visit new_patient_path
end
## WHENS ##
## THENS ##
Then(/^I should see the name of the hospital$/) do
  create_user_at_hospital_with_designation
  page.should have_content(@hospital.name)
end

Then(/^I should see the name of the city$/) do
  page.should have_content(@hospital.city)
end
