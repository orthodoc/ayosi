## Utility ##


## Given ##


## When ##
#
## Then ##

Then(/^I should not see the link to form a team$/) do
  create_patient
  sign_in_as_patient
  visit root_path
  page.should_not have_content("Set up your team")
end
