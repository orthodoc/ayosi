@http://www.pivotaltracker.com/story/show/63461588 @cancan @rolify
Feature: Team building by the surgeon
  As a surgeon
  I want to build a team

  Scenario: Create a team
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I create a team
    Then I should see the name of the team
    And I should see the team members
