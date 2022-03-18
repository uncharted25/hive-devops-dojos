/* eslint-env detox/detox */
import {Given} from "@cucumber/cucumber";
import {deepLinkNavigate, replaceText, shouldNotSee, shouldSee, tapById} from "./action";

Given("I visit Vitality screen and login with {string} and {string}", async (username, password) => {
  // Given I visit "Vitality" screen
  // console.debug("navigating");
  await deepLinkNavigate("Vitality");

  // When I tap "vitality-login-button"
  // console.debug("tapping login button");
  await tapById("vitality-login-button");

  // And I put "username" into "overlay-username-input"
  await replaceText(username, "overlay-username-input");

  // And I put "username" into "overlay-username-input"
  await replaceText(password, "overlay-password-input");

  // And I tap "overlay-login-button"
  await tapById("overlay-login-button");

  // And I should not see "activity-indicator"
  await shouldNotSee("activity-indicator");

  // And I tap "pin-overlay-cancel-button"
  await tapById("pin-overlay-cancel-button");

  // And I should not see "activity-indicator"
  await shouldNotSee("pin-overlay-cancel-button");

  // Then I should see "vitality-screen"
  await shouldSee("vitality-screen");
});

Given(
  "I visit Vitality screen and login with {string} and {string} as a {string} user",
  async (username, password, membershipType) => {
    // Given I visit "Vitality" screen
    // console.debug("navigating");
    await deepLinkNavigate("Vitality");

    // When I tap "vitality-login-button"
    // console.debug("tapping login button");
    await tapById("vitality-login-button");

    // And I put "username" into "overlay-username-input"
    await replaceText(username, "overlay-username-input");

    // And I put "username" into "overlay-username-input"
    await replaceText(password, "overlay-password-input");

    // And I tap "overlay-login-button"
    await tapById("overlay-login-button");

    // And I should not see "activity-indicator"
    await shouldNotSee("activity-indicator");

    // And I tap "pin-overlay-cancel-button"
    await tapById("pin-overlay-cancel-button");

    // And I should not see "activity-indicator"
    await shouldNotSee("pin-overlay-cancel-button");

    if (membershipType && membershipType.toLowerCase() === "free") {
      await tapById("close-button");
    }
    // Then I should see "vitality-screen"
    // await shouldSee("vitality-screen");
  },
);
/*
    Given I visit "Vitality" screen
    When I tap "vitality-login-button"
    And I put "vsuwansophon@th.palo-it.com" into "overlay-username-input"
    And I type "Aa123!@#" into "overlay-password-input"

    # Setup pin flow
    And I tap "overlay-login-button"
    And I wait 3 seconds
    And I should not see "activity-indicator"
    And I tap "pin-overlay-cancel-button"
    Then I should not see "pin-overlay-cancel-button"

    Then I should see "vitality-screen"

 */
