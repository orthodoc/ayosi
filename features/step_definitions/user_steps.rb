## Utility Steps ##

def create_visitor
  @visitor ||= { name: "Testy Visitor", email: "testy_user@example.com", password: "whatisthis", password_confirmation: "whatisthis" }
end

def create_patient_as_visitor
  @patient_visitor ||= { name: "Ramaswamy", email: "ramaswamy@ayosi.org", password: "whatisthis", password_confirmation: "whatisthis", category: "patient"}
end

def create_hospital_staff_as_visitor
  @hospital_staff_visitor ||= { name: "B D Baruah", email: "bdbaruah@ayosi.org", password: "bdb20133", password_confirmation: "bdb20133", category: "hospital_staff"}
end

def find_user
  @user ||= User.find_by_email(@visitor[:email])
end

def find_patient
  @user ||=User.find_by_email(@patient_visitor[:email])
end

def find_hospital_staff
  @user ||=User.find_by(email: (@hospital_staff_visitor[:email]))
end

def delete_user
  find_user
  @user.destroy unless @user.nil?
end

def delete_patient
  find_patient
  @user.destroy unless @user.nil?
end

def delete_hospital_staff
  find_hospital_staff
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_name", with: @visitor[:name]
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  fill_in "user_password_confirmation", with: @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_up_as_patient
  delete_patient
  visit '/users/sign_up'
  fill_in "user_name", with: @patient_visitor[:name]
  fill_in "user_email", with: @patient_visitor[:email]
  fill_in "user_password", with: @patient_visitor[:password]
  fill_in "user_password_confirmation", with: @patient_visitor[:password_confirmation]
  click_button "Sign up"
  find_patient
end

def sign_up_as_hospital_staff
  delete_hospital_staff
  visit '/users/sign_up'
  fill_in "user_name", with: @hospital_staff_visitor[:name]
  fill_in "user_email", with: @hospital_staff_visitor[:email]
  fill_in "user_password", with: @hospital_staff_visitor[:password]
  fill_in "user_password_confirmation", with: @hospital_staff_visitor[:password_confirmation]
  click_button "Sign up"
  find_hospital_staff
end

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, name: @visitor[:name], email: @visitor[:email], password: @visitor[:password], password_confirmation: @visitor[:password_confirmation])
end

def create_patient
  create_patient_as_visitor
  delete_patient
  @user = FactoryGirl.create(:user, name: @patient_visitor[:name], email: @patient_visitor[:email], password: @patient_visitor[:password], password_confirmation: @patient_visitor[:password_confirmation], category: @patient_visitor[:category])
end

def create_hospital_staff
  create_hospital_staff_as_visitor
  delete_hospital_staff
  @user = FactoryGirl.create(:user, name: @hospital_staff_visitor[:name], email: @hospital_staff_visitor[:email], password: @hospital_staff_visitor[:password], password_confirmation: @hospital_staff_visitor[:password_confirmation], category: @hospital_staff_visitor[:category])
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  click_button "Sign in"
end

def sign_in_as_hospital_staff
  visit '/users/sign_in'
  fill_in "user_email", with: @hospital_staff_visitor[:email]
  fill_in "user_password", with: @hospital_staff_visitor[:password]
  click_button "Sign in"
end

def sign_in_as_patient
  visit '/users/sign_in'
  fill_in "user_email", with: @patient_visitor[:email]
  fill_in "user_password", with: @patient_visitor[:password]
  click_button "Sign in"
end

def create_roles
  roles = %w[admin group_admin visitor guest patient doctor nurse physio secretary office_manager data_operator media_manager]
  roles.each do |r|
    Role.create(name: r)
  end
  hosp_staff = %w[doctor nurse physio secretary office_manager data_operator media_manager]
  hosp_roles = Array.new
  hosp_staff.each do |hs|
    role = Role.find_by(name: hs)
    hosp_roles << role
  end
end

## Given Steps ##
Given(/^I am not logged in$/) do
  visit 'users/sign_out'
end

Given(/^I do not exist as a user$/) do
  create_visitor
  delete_user
end

Given(/^I exist as a user$/) do
  create_user
end

Given(/^I am logged in$/) do
  create_user
  sign_in
end

Given(/^I am logged in as hospital staff$/) do
  create_hospital_staff
  sign_in_as_hospital_staff
end

Given(/^I am logged in as patient$/) do
  create_patient
  sign_in_as_patient
end

Given(/^I am assigned as a doctor$/) do
  create_hospital_staff
  create_roles
  sign_in_as_hospital_staff
  if @user.roles.count == 0
    role = Role.find_by(name: "doctor")
    choose("user_role_ids_#{role.id}")
    click_button "Submit"
  end
end

## When Steps ##

When(/^I sign up with valid user data$/) do
  create_visitor
  sign_up
end

When(/^I sign up with an invalid email$/) do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When(/^I sign up without a password$/) do
  create_visitor
  @visitor = @visitor.merge(password: "")
  sign_up
end

When(/^I sign up without a password confirmation$/) do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "")
  sign_up
end

When(/^I sign up with a mismatched password confirmation$/) do
  create_visitor
  @visitor = @visitor.merge(password_confirmation: "changeme123")
  sign_up
end

When(/^I sign in with valid credentials$/) do
  create_visitor
  sign_in
end

When(/^I return to the site$/) do
  visit '/'
end

When(/^I sign in with a wrong email$/) do
  @visitor = @visitor.merge(email: "not_testy_user@example.com")
  sign_in
end

When(/^I sign in with a wrong password$/) do
  @visitor = @visitor.merge(password: "wrongpassword")
  sign_in
end

When(/^I sign out$/) do
  visit '/users/sign_out'
end

When(/^I am on the new designation page$/) do
  visit '/designations/new'
end

When(/^I visit my page$/) do
  visit user_path(@user)
end

When(/^I look at my page$/) do
  visit user_path(@user)
end

When(/^I click on my name$/) do
  create_user
  sign_in
  click_link @user.name
end

When(/^I create a new designation at a hospital$/) do
  create_designation
  create_hospital
  click_link "Apply for a designation"
  fill_in "designation_name", with: @designation.name
  select @hospital.name, from: "designation_hospital_id"
  click_button "Submit"
end

When(/^I edit my designation$/) do
  create_user_at_hospital_with_designation
  visit user_path(@user)
  @new_designation = FactoryGirl.create(:designation)
  click_link @designation.name
  select @new_designation.name, from: "designation_name"
  select @hospital.name, from: "designation_hospital_id"
  click_button "Submit"
end

When(/^I click on the delete button$/) do
  create_user_at_hospital_with_designation
  visit user_path(@user)
  click_button "Delete"
  @designation.destroy
end

When(/^I request activation$/) do
  create_user_at_hospital_with_designation
  visit user_path(@user)
  click_button "Request"
end

## Then 

Then(/^I should see a successful sign up message$/) do
  page.should have_content "Welcome! You have signed up successfully."
end

Then(/^I should see an invalid email message$/) do
  page.should have_content "Emailis invalid"
end
  # The absent space b/w **Email and is** is necessary for the step to pass
  # Simple Form displays the error inline to the input box

Then(/^I should see a missing password message$/) do
  page.should have_content "Passwordcan't be blank"
  # The absent space b/w **Password and can't** is necessary for the step to pass
  # Simple Form displays the error inline to the input box
end

Then(/^I should see a missing password confirmation message$/) do
  page.should have_content "Password confirmationdoesn't match Password"
  # The absent space b/w **confirmation and doesn't** is necessary for the step to pass
  # Simple Form displays the error inline to the input box
end

Then(/^I should see a mismatched password message$/) do
  page.should have_content "Password confirmationdoesn't match Password"
  # The absent space b/w **confirmation and doesn't** is necessary for the step to pass
  # Simple Form displays the error inline to the input box
end

Then(/^I see an invalid login message$/) do
  page.should have_content "Invalid email or password."
end

Then(/^I should be signed out$/) do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Logout"
end

Then(/^I see a successful sign in message$/) do
  page.should have_content "Signed in successfully"
end

Then(/^I should be signed in$/) do
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
end

Then(/^I should see a signed out message$/) do
  page.should have_content "Signed out successfully."
end

Then(/^I should see my name$/) do
  page.should have_content(@user.name)
end

Then(/^I should see my new designation$/) do
  create_user_at_hospital_with_designation
  visit user_path(@user)
  page.should have_content(@designation.name)
end

Then(/^I should be on my page$/) do
  visit user_path(@user)
end

Then(/^I should see my edited designation$/) do
  page.should have_content(@new_designation.name)
end

Then(/^I should not see the designation$/) do
  page.should_not have_content(@designation.name)
end

Then(/^it should be in an inactive state$/) do
  visit user_path(@user)
  @designation.inactive?
  page.should have_content("Inactive")
end

Then(/^I should see a request button$/) do
  visit user_path(@user)
  @designation.inactive?
  page.should have_button("Request")
end

Then(/^I should see a pending state$/) do
  page.should have_content("Pending")
end

Then(/^I should be on the home page$/) do
  visit root_path
end

Then(/^I should see the word guest$/) do
  page.should have_content @user.category.titleize
end

Then(/^I should see the word hospital staff$/) do
  page.should have_content @user.category.titleize
end

Then(/^I should see the word patient$/) do
  page.should have_content @user.category.titleize
end

Then(/^I should not see the words visitor, guest or patient$/) do
  %w[visitor guest patient].each do |word|
    page.should_not have_content(word)
  end
end

Then(/^I should not see the words visitor, guest or hospital staff$/) do
  ["visitor", "guest", "hospital staff"].each do |word|
    page.should_not have_content(word)
  end
end

Then(/^I should see the name doctor$/) do
  page.should have_content(@user.roles.first.name.titleize)
end
