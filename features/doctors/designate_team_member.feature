@http://www.pivotaltracker.com/story/show/63461400 @cancan @rolify
Feature: Assigning designations to team members
  As a surgeon with a team
  I want to assign designations to team members to restrict access

  Scenario: Approve designation
    Given I create a team with team members
    And I visit the team page
    Then I should see the team members
    And I should see the designations of each team member
    And I should see the state of each designation as pending
    When I activate the designation
    Then the state of designation must change to active
