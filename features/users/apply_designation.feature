Feature: Apply for designation
  As a registered user at the website
  I want to apply for a specific designation

  Background:
    Given I exist as a user
    And I am logged in
    Then I should see my name
    When I click on my name
    Then I should be on my page

  Scenario: Apply for designation
    When I create a new designation at a hospital
    Then I should be on my page
    And I should see my new designation
    And it should be in an inactive state
    And I should see a request button

  Scenario: Edit a designation
    When I edit my designation
    Then I should be on my page
    And I should see my edited designation

  Scenario: Delete a designation
    When I click on the delete button
    Then I should not see the designation

  Scenario: Request activation
    When I request activation
    Then I should see a pending state
