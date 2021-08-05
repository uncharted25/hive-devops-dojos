Feature: WebView user should be able see checkout screen
  Scenario: A logged older version of iOS application should see TIDPLUS as inactive
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.36.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "subscriptions" page
    And I wait around 30 seconds and should see element "subscriptions_container"
    Then I should see the value "inactive" in "subscriptions_[TIDPLUS]_status"

  Scenario: A logged iOS user should be able to open the checkout page from subscription
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "subscriptions" page
    And I wait around 30 seconds and should see element "subscriptions_container"
    And I click "subscriptions_[TIDPLUS]_status"
    Then I am redirected to "checkout?productCode=TIDPLUS" page
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    When I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                             | price     | freeTrial    |
      | TIDPLUS_0 | Monthly | After free trial, It will be ฿59/month. Cancel anytime. | ฿59/month | 1 Month Free |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                          | ฿599      |              |
    And I should see more than 3 movies in highlight section
    And I should see the value "฿59/month" in "checkout_paymentMethod_[PAYAPPLE]_paymentPrice"
    And I should see the value "App Store" in "checkout_paymentMethod_[PAYAPPLE]_sourceTitle"
    And I should see the value "Pay using your Apple ID" in "checkout_paymentMethod_[PAYAPPLE]_sourceDescription"
    And I should not see element "checkout_paymentMethod_link"
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled

  Scenario: A logged iOS user should be able to open the checkout page from application
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "offer_code=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    When I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                             | price     | freeTrial    |
      | TIDPLUS_0 | Monthly | After free trial, It will be ฿59/month. Cancel anytime. | ฿59/month | 1 Month Free |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                          | ฿599      |              |
    And I should see more than 3 movies in highlight section
    And I should see the value "฿59/month" in "checkout_paymentMethod_[PAYAPPLE]_paymentPrice"
    And I should see the value "App Store" in "checkout_paymentMethod_[PAYAPPLE]_sourceTitle"
    And I should see the value "Pay using your Apple ID" in "checkout_paymentMethod_[PAYAPPLE]_sourceDescription"
    And I should not see element "checkout_paymentMethod_link"
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should not see element "checkout_button_cancel"

    When I click "checkout_button_buyNow"
    Then I wait "1" seconds for "logs"
    Then I should see log "[ios_paynow]" in console with value as follows
      | key         | value                          |
      | url         | trueid://subscription          |
      | offer_code  | TIDPLUS_TRIAL1M_BPN_RC_EVG_REG |
      | cms_id      | nQeRvb0k957B                   |
      | source_type | payapple                       |

  Scenario: A logged iOS user that have TIDPLUS free trial should not see TIDPLUS free trial package anymore
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_USER_2"
    And I never update my profile "me" settings
    And I never setup pincode
    When I open the "checkout" page with query "offer_code=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    When I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I should see more than 3 movies in highlight section
    And I should not see element "checkout_offer_[TIDPLUS_TRIAL1M_BPN_RC_EVG_REG]"
    And I should see the value "฿59/month" in "checkout_paymentMethod_[PAYAPPLE]_paymentPrice"
    And I should see the value "App Store" in "checkout_paymentMethod_[PAYAPPLE]_sourceTitle"
    And I should see the value "Pay using your Apple ID" in "checkout_paymentMethod_[PAYAPPLE]_sourceDescription"
    And I should not see element "checkout_paymentMethod_link"
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should not see element "checkout_button_cancel"

    When I click "checkout_button_buyNow"
    Then I wait "1" seconds for "logs"
    Then I should see log "[ios_paynow]" in console with value as follows
      | key         | value                   |
      | url         | trueid://subscription   |
      | offer_code  | TIDPLUS2_BPN_RC_EVG_REG |
      | cms_id      | nQeRvb0k957B            |
      | source_type | payapple                |

  Scenario: A logged iOS user should be able to checkout a movie
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=J29O6r46ODmK" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the value "A Star Is Born" in "checkout_title"
    And I should not see element "checkout_offer_display_button"
    And I should see the following items "checkout_offer"
      | id                           | title               | price | description                                                                                              |
      | movie_0 | Rent a single movie | ฿59   | Movie will be kept in your library for 30 days. Enjoy unlimited viewing within 48 hours after first play |
    And I should see the value "฿59" in "checkout_paymentMethod_[PAYAPPLE]_paymentPrice"
    And I should see the value "App Store" in "checkout_paymentMethod_[PAYAPPLE]_sourceTitle"
    And I should see the value "Pay using your Apple ID" in "checkout_paymentMethod_[PAYAPPLE]_sourceDescription"
    And I should not see element "checkout_paymentMethod_link"
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should not see element "checkout_button_cancel"
    When I click "checkout_button_buyNow"
    Then I wait "1" seconds for "logs"
    Then I should see log "[ios_paynow]" in console with value as follows
      | key         | value                        |
      | url         | trueid://subscription        |
      | offer_code  | WARNERTVOD059_PNN_OC_30D_ALA |
      | cms_id      | J29O6r46ODmK                 |
      | source_type | payapple                     |


  Scenario: A logged iOS user should not be able to checkout with invalid offer_code
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "offer_code=RANDOM_OFFERCODE&cms_id=J29O6r46ODmK" and wait around 1 minute
    Then I should see element "common_placeholder_serverError"
    And I should see the value "offer_code is not found\n(10003)" in "layout_placeholder_detail"

  Scenario: A logged iOS user should not be able to checkout with TVOD offer_code and missing cms_id
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA" and wait around 1 minute
    Then I should see element "common_placeholder_serverError"
    And I should see the value "content_id is required for TVOD\n(400)" in "layout_placeholder_detail"

  Scenario: A logged iOS user should not be able to checkout with unmatch TVOD offer_code and cms_id
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=RaNdomCMsId" and wait around 1 minute
    Then I should see element "common_placeholder_serverError"
    And I should see the value "The movie is not available. Please try again later.\n(400)" in "layout_placeholder_detail"

  Scenario: A logged iOS user should not be able to checkout with TVOD offer_code and invalid cms_id
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=1al4bvGw1BVa" and wait around 1 minute
    Then I should see element "common_placeholder_serverError"
    And I should see the value "content_id is invalid\n(10018)" in "layout_placeholder_detail"

  @skip
  # Re-enable again after find proper PDF viewer plugin
  Scenario: A logged iOS user should be able to read term & condition movie as PDF modal
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_button_termCond"
    Then I should see element "checkout_modal_termCond"
    When I click "PdfModal_button_close"
    Then element "checkout_modal_termCond" should be gone

  Scenario: A logged iOS user should be able to read term & condition as PDF page
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_button_termCond"
    Then I am redirected to "static/products/pdf/TIDPLUS.pdf" page

  Scenario: A logged iOS user should be able to read privacy policy as modal
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | ios             |
      | appVersion | 2.39.0          |
      | device_id  | automate_device |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_button_privacy"
    Then I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal_title"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal_detail"

  @skip
  # skip to deploy test on real device
  Scenario: A logged Android user should be able to see point can pay
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | android         |
      | appVersion | 2.41.0          |
      | device_id  | automate_device |
    And I login with "ACCOUNT_ALL_SOURCES"
    When I open the "checkout" page with query "productCode=FAMILY" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_paymentMethod_link"
    And I scroll down on "checkout_paymentMethod"
    Then I should see element "checkout_paymentMethod_[truepointpoint]_sourceTitle"
    And I should see element "checkout_paymentMethod_[truepointpoint]_paymentPrice"
    And I should see the value "299 pts." in "checkout_paymentMethod_[truepointpoint]_paymentPrice"

  Scenario: A logged Android user (have sources) should not see cancel button on checkout page
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | android         |
      | appVersion | 2.42.0          |
      | device_id  | automate_device |
      | viewmode   | full            |
    And I login with "DEFAULT_USER_2"
    And I never update my profile "me" settings
    And I never setup pincode
    When I open the "checkout" page with query "productCode=FAMILY"
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should not see element "checkout_button_cancel"

  Scenario: A logged Android user (no sources) should not see cancel button on checkout page
    Given I open browser webview with configuration
      | key        | value           |
      | appName    | trueid          |
      | platform   | android         |
      | appVersion | 2.42.0          |
      | device_id  | automate_device |
      | viewmode   | full            |
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "productCode=FAMILY"
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should not see element "checkout_button_cancel"