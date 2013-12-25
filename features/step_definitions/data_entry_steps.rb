## UTILITY METHODS ##

def create_hospital
  @hospital = FactoryGirl.create(:hospital)
end

def create_user_at_hospital_with_designation
  create_user
  create_hospital
  @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
  sign_in
  @hospital = @user.designations.find_by_name(@designation.name).hospital
end

def build_patient
  @patient = FactoryGirl.build(:patient)
end

## Given Steps ##

Given(/^I am on the data entry page$/) do
  visit new_patient_path
end
## When Steps ##
## Then Steps ##
Then(/^I should see the name of the hospital$/) do
  create_user_at_hospital_with_designation
  page.should have_content(@hospital.name)
end

Then(/^I should see the name of the city$/) do
  page.should have_content(@hospital.city)
end
