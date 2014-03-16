Feature: Apply for designation
  As a registered user at the website
  I want to apply for a specific designation

  Background:
    Given I exist as a user
    And I am logged in
    Then I should see my name
    And I should see the word guest
    When I click on my name
    Then I should be on my page

  Scenario: Logged in as hospital staff
    Given I am logged in as hospital staff
    Then I should see the word hospital staff
    And I should not see the words visitor, guest or patient

  Scenario: Apply for designation as a doctor
    Given I am logged in as hospital staff
    And I am assigned as a doctor
    Then I should see the name doctor
    And I create a new designation at a hospital
    Then I should be on my page
    And I should see my new designation

  Scenario: Edit a designation as hospital staff
    Given I am logged in as hospital staff
    When I edit my designation
    Then I should be on my page
    And I should see my edited designation

  @javascript
  Scenario: Delete a designation
    When I click on the delete button
    Then I should not see the designation

  Scenario: Logged in as patient
    Given I am logged in as patient
    Then I should see the word patient
    And I should not see the words visitor, guest or hospital staff

  Scenario: Select hospital as a patient
   Given I am logged in as patient
   When I select the hospital
   Then I should see the name of the hospital

  Scenario: Edit a hospital as a patient
    Given I am logged in as patient
    When I edit the hospital
    Then I should be on my page
    And I should see the edited hospital
