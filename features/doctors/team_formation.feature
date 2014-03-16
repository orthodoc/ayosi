Feature: Team building by the surgeon
  As a surgeon
  I want to build a team

  Background:
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I create a team

    Scenario: Create a team
      Then I should be on the new team page
      And I should see the name of the team
      And I should be a member of the team
      And I should see the team members
      #And I should see the designation of each team member
      And I should see the membership status of each member

    Scenario: Editing a team
      When I edit the team
      Then I should see the name of the new team

    Scenario: Inviting team members
      When I am on the team page
      Then I should see the invite by email link
      When I click on the invite by email link
      Then I should be on the send invitation page

    Scenario: Approve membership
    
  Scenario: Continuing without froming a team
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I skip team creation
    Then I should be on the new patient page

