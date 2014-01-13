@http://www.pivotaltracker.com/story/show/63461638
Feature: Surgeon without a team
  As surgeon
  I want to enter data without a team

  Scenario: Continuing without froming a team
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I skip team creation
    Then I should be on the new patient page
