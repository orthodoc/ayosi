@http://www.pivotaltracker.com/story/show/63673786 @cancan @rolify
Feature: Restricting team creation to a doctor
  As a patient
  I should not be able to create a team

  Scenario: Attempting to create team as a patient
    Given I am logged in as patient
    Then I should not see the link to form a team
