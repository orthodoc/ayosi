@http://www.pivotaltracker.com/story/show/63463318 @devise @invitable
Feature: Sending invitations to team members
  As a surgeon
  And I want to invite team members

  Scenario: Inviting team members
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I create a team
    And I am on the team page
    Then I should see the invite by email link
    When I click on the invite by email link
    Then I should be on the send invitation page
