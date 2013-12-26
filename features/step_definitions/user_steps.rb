## Utility Steps ##

def create_visitor
  @visitor ||= { name: "Testy Visitor", email: "testy_user@example.com", password: "whatisthis", password_confirmation: "whatisthis" }
end

def find_user
  @user ||= User.find_by_email(@visitor[:email])
end

def delete_user
  find_user
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

def create_user
  create_visitor
  delete_user
  @user = FactoryGirl.create(:user, name: @visitor[:name], email: @visitor[:email], password: @visitor[:password], password_confirmation: @visitor[:password_confirmation])
end

def sign_in
  visit '/users/sign_in'
  fill_in "user_email", with: @visitor[:email]
  fill_in "user_password", with: @visitor[:password]
  click_button "Sign in"
end

def create_designation
  @designation = FactoryGirl.create(:designation)
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
  select @designation.name, from: "designation_name"
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
  click_link "Delete"
  @designation.destroy
end

When(/^I request activation$/) do
  create_user_at_hospital_with_designation
  visit user_path(@user)
  click_link "Request"
end

## Then 

Then(/^I should see a successful sign up message$/) do
  page.should have_content "Welcome! You have signed up successfully."
end

Then(/^I should see an invalid email message$/) do
  page.should have_content "Emailis invalid"
end

Then(/^I should see a missing password message$/) do
  page.should have_content "Passwordcan't be blank"
  # The absent space b/w Password and can't is necessary for the step to pass
  # Simple Form displays the error inline to the input box
end

Then(/^I should see a missing password confirmation message$/) do
  page.should have_content "Password confirmationdoesn't match Password"
  # The absent space b/w confirmation and doesn't is necessary for the step to pass
  # Simple Form displays the error inline to the input box
end

Then(/^I should see a mismatched password message$/) do
  page.should have_content "Password confirmationdoesn't match Password"
  # The absent space b/w confirmation and doesn't is necessary for the step to pass
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
  page.should have_content("Request")
end

Then(/^I should see a pending state$/) do
    page.should have_content("Pending")
end
