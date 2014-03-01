Feature: Team building by the surgeon
  As a surgeon
  I want to build a team

  Scenario: Create a team
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I create a team
    Then I should be on the new team page
    And I should see the name of the team
    And I should be a member of the team
    #And I should see the team members

  Scenario: Editing a team
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    And I have created a team
    When I edit the team
    Then I should see the name of the new team

  Scenario: Inviting team members
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I create a team
    And I am on the team page
    Then I should see the invite by email link
    When I click on the invite by email link
    Then I should be on the send invitation page

  Scenario: Continuing without froming a team
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    When I skip team creation
    Then I should be on the new patient page

    # Scenario: Approve designation
    #Given I create a team with team members
    #And I visit the team page as a doctor
    #Then I should see the team members
    #And I should see the designations of each team member
