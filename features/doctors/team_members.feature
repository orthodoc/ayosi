@http://www.pivotaltracker.com/story/show/63463318 @devise @invitable
Feature: Sending invitations to team members
  As a surgeon
  And I want to invite team members

  Scenario: Inviting team members
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I create a team
    And I am on the team page
    And I invite team members
    Then I should see the name of the member
    And I should the status as invited
