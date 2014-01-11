@http://www.pivotaltracker.com/story/show/63666488 @cancan @rolify
Feature: Editing a team by surgeon
  As a surgeon
  I should be able to edit the team I formed

  Scenario: Editing a team
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    And I have created a team
    When I edit the team
    Then I should see the name of the new team
