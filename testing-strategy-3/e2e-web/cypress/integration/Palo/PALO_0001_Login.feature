Feature: Login

  Scenario: As a palo user, I want to login the PALO system so that I can become the logged in user
    Given I open the "http://localhost:3000" page
    # TODO
    When I put the value "palo@it.com" in the field "username"
    And I put the value "1qa2ws" in the field "password"
    And I click on "submit" 
    Then I should see text "Logged in!"

  Scenario: As a palo user, I want to login the PALO system so that I can become the logged in user
    Given I open the "http://localhost:3000" page
    # TODO
    When I put the value "notpalo@it.com" in the field "username"
    And I put the value "xxxxxxx" in the field "password"
    And I click on "submit" 
    Then I should see text "Please verify your credentials."