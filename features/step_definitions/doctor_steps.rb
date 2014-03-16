## Utility steps ##

def create_the_hospital
  @the_hospital ||= { name: "Morits Hospital", city: "Rigor Exposure hospital" }
end

def find_the_hospital
  @hospital ||= Hospital.find_by(name: @the_hospital[:name])
end

def delete_the_hospital
  find_the_hospital
  @hospital.destroy unless @hospital.nil?
end

def create_hospital
  create_the_hospital
  delete_the_hospital
  @hospital = FactoryGirl.create(:hospital, name: @the_hospital[:name], city: @the_hospital[:city])
end

def create_doctor_at_hospital
  create_hospital
  create_hospital_staff
  ## find_by_name method in rolify is deprecated, so add_role method throws up a
  #warning. Made it verbose to avoid the warning!!
  doctor = Role.find_by(name: "doctor")
  @user = User.find_by(name: @hospital_staff_visitor[:name])
  @user.roles << doctor unless doctor.nil?
end

def create_the_designation_name
  create_hospital_staff_as_visitor
  create_the_hospital
  @the_designation ||= { name: "Consultant", user: @hospital_staff_visitor[:name], hospital: @the_hospital[:name] }
end

def find_the_designation
  @designation = Designation.find_by(name: @the_designation[:name])
end

def delete_the_designation
  find_the_designation
  @designation.destroy unless @designation.nil?
end

def create_designation
  @user = User.find_by(name: @hospital_staff_visitor[:name])
  @hospital = Hospital.find_by(name: @the_hospital[:name])
  create_the_designation_name
  delete_the_designation
  @designation = FactoryGirl.create(:designation, name: @the_designation[:name], user: @user, hospital: @hospital)
end

def create_the_team
  create_hospital_staff_as_visitor
  create_hospital
  @the_team ||= { name: "JRGC", user: @hospital_staff_visitor[:name], hospital: @the_hospital[:name] }
end

def find_the_team
  @team = Team.find_by(name: @the_team[:name])
end

def delete_the_team
  find_the_team
  @team.destroy unless @team.nil?
end

def build_team
  @team = FactoryGirl.build(:team)
end

def create_team
  build_team
  create_hospital
  sign_in_as_doctor
  @user_designation = FactoryGirl.create(:designation, hospital: @hospital)
  @nurse_designation = FactoryGirl.create(:designation, hospital: @hospital)
  @nurse = @nurse_designation.user
  @secretary_designation = FactoryGirl.create(:designation, hospital: @hospital)
  @secretary = @secretary_designation.user
  visit new_team_path
  fill_in "team_name", with: @team[:name]
  select @hospital.name, from: "team_hospital_id"
  click_button "Submit"
  @team.update_attributes(user: @user)
  @team.members << [@nurse, @secretary, @user]
  @team.save
end

def create_team_with_members
  create_team
  @nurse = FactoryGirl.create(:user)
  @nurse_designation = FactoryGirl.create(:designation, user: @nurse, hospital: @user.hospitals[0])
  @secretary = FactoryGirl.create(:user)
  @secretary_designation = FactoryGirl.create(:designation, user: @secretary, hospital: @user.hospitals[0])
  @team.members << [@nurse,@secretary]
end

def create_doctor_at_hospital_with_designation
  create_doctor_at_hospital
  create_designation
end

def sign_in_as_doctor
  create_doctor_at_hospital_with_designation
  sign_in_as_hospital_staff
end

## Given ##

Given(/^I have created a team$/) do
end

Given(/^I create a team with team members$/) do
end

Given(/^I visit the team page as a doctor$/) do
end

Given(/^I visit the team page$/) do
  visit team_path(@team)
end

## When ##

When(/^I create a team$/) do
  create_team
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
  sign_in_as_doctor
  create_team_with_members
  visit team_path(@team)
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

Then(/^I should see the designation of each team member$/) do
  @team.members.each do |member|
    hospital = Hospital.find_by(name: @the_hospital[:name])
    @designation = member.designations.find_by(hospital: hospital)
    page.should have_content(@designation.name)
  end
end

Then(/^I should see my designation$/) do
  create_team_with_members
  visit team_path(@team)
  page.should have_content(@team.owner.designation(@team).name.titleize) unless @team.owner.designation(@team).nil?
end

Then(/^I should be on the new team page$/) do
  create_team
  visit team_path(@team)
end

Then(/^I should see my my name$/) do
  page.should have_content(@user.name.titleize)
end

Then(/^I should be a member of the team$/) do
  @team.members.include?(@team.owner)
end

Then(/^I should see the membership status of each member$/) do
  @team.members.each do |member|
    page.should have_content(member.memberships.find_by(team: @team).aasm_state.capitalize)
  end
end
