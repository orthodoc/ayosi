## Utility steps ##

def create_doctor_at_hospital
  create_hospital
  create_hospital_staff
  ## find_by_name method in rolify is deprecated, so add_role method throws up a
  #warning. Made it verbose to avoid the warning!!
  role = Role.find_by(name: "doctor")
  @user.roles << role
end

def create_doctor_at_hospital_with_designation
  create_doctor_at_hospital
  @designation = FactoryGirl.create(:designation, user: @user, hospital: @hospital)
end

def sign_in_as_doctor
  create_doctor_at_hospital_with_designation
  sign_in_as_hospital_staff
end

def build_team
  @team = FactoryGirl.build(:team)
end

def create_team
  @team = FactoryGirl.create(:team)
end
## Given ##

Given(/^I have created a team$/) do
  create_team
end

## When ##

When(/^I create a team$/) do
  create_doctor_at_hospital_with_designation
  sign_in_as_doctor
  build_team
  click_link "Set up your team"
  fill_in "team_name", with: @team.name
  select @hospital.name, from: "team_hospital_id"
  click_button "Submit"
end

When(/^I edit the team$/) do
  create_doctor_at_hospital_with_designation
  sign_in_as_doctor
  create_team
  visit team_path(@team)
  click_link @team.name
  @new_team = FactoryGirl.build(:team)
  fill_in "team_name", with: @new_team.name
  select @user.hospitals.first.name, from: "team_hospital_id"
  click_button "Submit"
end

When(/^I skip team creation$/) do
  click_link "Skip!"
end

## Then ##

Then(/^I should see the name of the team$/) do
  page.should have_content(@team.name)
end

Then(/^I should see the link to add team members$/) do
  page.should have_content("Add team members")
end

Then(/^I should see the name of the new team$/) do
  page.should have_content(@new_team.name)
end

Then(/^I should be on the new patient page$/) do
  visit new_patient_path
end
