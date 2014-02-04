## Utility steps ##

def create_doctor_at_hospital
  create_hospital
  create_hospital_staff
  ## find_by_name method in rolify is deprecated, so add_role method throws up a
  #warning. Made it verbose to avoid the warning!!
  doctor = Role.find_by(name: "doctor")
  @user.roles << doctor unless doctor.nil?
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

def create_team_with_members
  create_doctor_at_hospital_with_designation
  @team = FactoryGirl.create(:team, user: @user)
  @nurse = FactoryGirl.create(:user)
  nurse = Role.find_by(name: "nurse")
  @nurse.roles << nurse unless nurse.nil?
  @team.members << @nurse
end
## Given ##

Given(/^I have created a team$/) do
  create_team
end

Given(/^I create a team with team members$/) do
  create_team_with_members
end

Given(/^I visit the team page$/) do
  visit team_path(@team)
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
  visit root_path
  click_link "Skip!"
end

When(/^I am on the team page$/) do
  create_team
  visit team_path(@team)
end

When(/^I click on the invite by email link$/) do
  click_link "Invite by email"
end


## Then ##

Then(/^I should see the name of the team$/) do
  page.should have_content(@team.name)
end

Then(/^I should see the name of the new team$/) do
  page.should have_content(@new_team.name)
end

Then(/^I should see the team members$/) do
  @team.members.each do |member|
    page.should have_content(member.name)
  end
end

Then(/^I should be on the new patient page$/) do
  visit new_patient_path
end

Then(/^I should see the invite by email link$/) do
  page.should have_link("Invite by email")
end

Then(/^I should be on the send invitation page$/) do
  visit new_user_invitation_path
end

Then(/^I should see the designations of each team member$/) do
  @team.members.each do |member|
    page.should have_content(member.default_designation) unless member.nil?
  end
end

Then(/^I should see the state of each designation as pending$/) do
  @team.members.each do |member|
    page.should have_content(member.default_designation.aasm_state) unless member.nil?
  end
end
