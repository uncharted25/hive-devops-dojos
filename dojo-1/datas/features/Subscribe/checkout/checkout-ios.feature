@mobile @iosV2
Feature: iOS user should be able see checkout screen
  Scenario: A logged iOS user should be able to open the checkout page from subscription
    Given I go to screen "package" with user "DEFAULT_USER_1"
    When I click "**/XCUIElementTypeButton[`label == 'Get it now'`][2]"
    Then I should see element "//XCUIElementTypeButton[@name='Buy now']"
  @skip
  Scenario: A logged iOS user should be able to open the checkout page from TV player
    Given I go to screen "home" with user "PROD_BASIC_USER"
    And I wait "5" seconds for "Home screen"
    When I click "**/XCUIElementTypeStaticText[`label == 'Live TV'`]"
    And I click "**/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[1]/XCUIElementTypeOther/XCUIElementTypeScrollView/XCUIElementTypeOther[1]/XCUIElementTypeOther[3]/XCUIElementTypeOther[2]"
    And I click "**/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeScrollView/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeCell[1]"
    And I wait "4" seconds for "Channel Player"
    # And I click "**/XCUIElementTypeButton[`label == 'ic mdplayer play'`]"
    Then I should see element "//XCUIElementTypeButton[@name='Buy now']"
  Scenario: A logged iOS user should be able to open the checkout page from Movie player
    Given I go to screen "home" with user "DEFAULT_USER_1"
    And I wait "5" seconds for "Home screen"
    When I click "**/XCUIElementTypeButton[`label == 'ic search black'`]"
    And I click "**/XCUIElementTypeStaticText[`label == 'New Movies'`]"
    # And I click "**/XCUIElementTypeWindow[1]/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeCell[3]"
    And I click "**/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther[2]/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeCell[2]"
    And I click "**/XCUIElementTypeWindow[1]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeCell[2]/XCUIElementTypeOther/XCUIElementTypeOther/XCUIElementTypeCollectionView/XCUIElementTypeCell[1]"
    And I click "**/XCUIElementTypeButton[`label == 'ic mdplayer play'`]"
    And I wait "4" seconds for "Channel Player"
    Then I should see element "//XCUIElementTypeButton[@name='Buy now']"

  @skip
  Scenario: A logged iOS user should be able to see IAP from subscription checkout
    Given I go to screen "package" with user "DEFAULT_USER_1"
    When I click "**/XCUIElementTypeButton[`label == 'Get it now'`][2]"
    Then I should see element "//XCUIElementTypeButton[@name='Buy now']"
    And I click "//XCUIElementTypeButton[@name='Buy now']"
    And I wait "10" seconds for "IAP"
    And I should see all source
    And I should see element "**/XCUIElementTypeStaticText[`label == '1 MONTH TRIAL, FREE'`]"
    And I should see element "**/XCUIElementTypeStaticText[`label == 'Subscribe'`]"
    And I should see element "**/XCUIElementTypeStaticText[`label == 'STARTING JUL 1, 2021, $1.99/MONTH'`]"