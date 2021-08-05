@skip
Feature: A user should be able to checkout from myaccount subscriptions page

  The checkout feature will including choosing offers that the product have and selected a payment method.
  Important notes:
  - There's no free trial feature on web at the moment
  - There's no DCB payment channel for 1-year TIDPLUS package
  - DCB backend system will be available to do transaction in the afternoon of the day
  - TOL limitation: ฿450 a day

  @noparallel
  @skip
  @dcb
  # got error from subscription api
  Scenario: A logged user should be able to purchase Recurring TIDPLUS with DCB
    Given I login with "DCB_ACCOUNT_POSTPAID"
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "0392" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription         |
      | ฿59/month    | ●0392        | Charge to TrueMove H Bill |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  @skip
  # This test was skipped because the account reached payment limit and we didn't have api to reset yet
  Scenario: A logged user should be able to purchase Recurring EPL successfully with DCB
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "EPLNP_NPN_00_30D_ALA,EPL2021_NPN_OC_1D_ALA,EPLNP_NPN_00_7D_ALA,EPL2021_NPN_RC_EVG_ALA" before
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id    | title       | description                                     | price      |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | ฿1900      |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month |
      | EPL_2 | 7 Days      | One time charge                                 | ฿149       |
      | EPL_3 | 1 Day       | One time charge                                 | ฿119       |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    And I should see element "checkout_offer_[EPL_0]_selected"
    And I should see "2854" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription         |
      | ฿299/month   | ●0392 | Charge to TrueMove H Bill |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  @skip
  # This test was skipped because the account reached payment limit and we didn't have api to reset yet
  Scenario: A logged user should be able to purchase 7-day OC EPL successfully with DCB
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "EPLNP_NPN_00_30D_ALA,EPL2021_NPN_OC_1D_ALA,EPLNP_NPN_00_7D_ALA,EPL2021_NPN_RC_EVG_ALA" before
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id    | title   | description                                     | price      |
      | EPL_0 | Monthly | You will be charged ฿299/month. Cancel anytime. | ฿299/month |
      # instead of multiple packages, we display "see more"
    When I click "checkout_offer_display_button"
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    When I click "checkout_offer_[EPLNP_NPN_00_7D_ALA]"
    Then I should see element "checkout_offer_[EPLNP_NPN_00_7D_ALA]_selected"
    And I should see "2854" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription               |
      | ฿149         | ●0392 | Charge to TrueMove H Bill |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel @dcb @skip
  # API return 14159
  Scenario: A logged user should be able to purchase TVOD successfully with DCB
    Given I login with "DCB_ACCOUNT_POSTPAID"
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=J29O6r46ODmK" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the value "A Star Is Born" in "checkout_title"
    And I should see the following items "checkout_offer"
      | id      | title               | price | description                                                                                              |
      | movie_0 | Rent a single movie | ฿59   | Movie will be kept in your library for 30 days. Enjoy unlimited viewing within 48 hours after first play |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see "0392" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle        | sourceDescription               |
      | ฿59         | ●0392 | Charge to TrueMove H Bill |
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"

  @noparallel
  @skip
  # This test was skip because of using `A logged user should be able to purchase Recurring TIDPLUS successfully with TrueMoney Wallet than redirect to /subscriptions` instead to avoid error `Order in progress`
  Scenario: A logged user should be able to purchase Recurring TIDPLUS successfully with TrueMoney Wallet
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=3501" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I should not see element "checkout_offer_[TIDPLUS_BPN_OC_1Y_REG]"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      # | TIDPLUS_BPN_OC_1Y_REG   | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I click "checkout_offer_display_button"
    And I should not see element "checkout_offer_[TIDPLUS_1]"
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see the value "฿59/month" in "checkout_paymentMethod_[truemoney3501]_paymentPrice"
    And I should see the value "●3501" in "checkout_paymentMethod_[truemoney3501]_sourceTitle"
    And I should see my truemoney "3501" balance more than 59
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  Scenario: A logged user should be able to purchase 1-year OC TIDPLUS with TrueMoney Wallet
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy any offer from "TIDPLUS" before
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=3501" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_benefit"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    When I click "checkout_offer_[TIDPLUS_1]"
    Then I should see element "checkout_offer_[TIDPLUS_1]_selected"
    And I should not see element "checkout_offer_[TIDPLUS_0]"
    And I should see "3501" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription |
      | ฿599         | ●3501        |                   |
    # And I should see the value "฿599" in "checkout_paymentMethod_[src_2nd9fq4b2djn]_paymentPrice"
    # And I should see the value "●3501" in "checkout_paymentMethod_[src_2nd9fq4b2djn]_sourceTitle"
    And I should see my truemoney "3501" balance more than 599
    When I click "checkout_offer_display_button"
    Then I should see element "checkout_offer_[TIDPLUS_0]"
    Then I should not have "button_attempt" event inside dataLayer
    Then I should not have "button_success" event inside dataLayer

    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    And I should have "button_attempt" event named "PaymentMethodAndPurchase" inside dataLayer
    And I should have "button_success" event named "PaymentMethodAndPurchase" inside dataLayer
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  # Cannot purchase package over ฿400 with TrueMoveH
  Scenario: A logged user should not be able to purchase 1-year OC TIDPLUS with TrueMoveH
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should not see element "checkout_paymentMethod_[truemoveh0601]_sourceTitle"

  @noparallel @skip
  #API return 15003
  Scenario: A logged user should be able to purchase Recurring EPL successfully with TrueMoney Wallet
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "EPLNP_NPN_00_30D_ALA,EPL2021_NPN_OC_1D_ALA,EPLNP_NPN_00_7D_ALA,EPL2021_NPN_RC_EVG_ALA" before
    When I open the "checkout" page with query "productCode=EPL&sof=3501" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id    | title       | description                                     | price      |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | ฿1900      |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month |
      | EPL_2 | 7 Days      | One time charge                                 | ฿149       |
      | EPL_3 | 1 Day       | One time charge                                 | ฿119       |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    And I should see element "checkout_offer_[EPL_0]_selected"
    And I click "checkout_offer_[EPL_2]"
    And I should see "3501" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription    |
      | ฿299/month   | ●3501 |                      |
    And I should see my truemoney "3501" balance more than 299
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected to "subscriptions" page
    And element "loading_placeholder" should be gone
    And I should see the following items "subscriptions"
      | id  | title                 | status | price  |
      | EPL | True Premier Football | Active | ฿1,900 |

  @noparallel
  Scenario: SUBSCRIBE-342 A logged trusted user should be able to purchase 7-day OC EPL successfully with TrueMoney Wallet and pin verification
    Given I login with "DEFAULT_USER_1"
    And I have setup my pin as "1234"
    And I enable purchase pincode
    And I never buy any offer from "EPL" before
    When I open the "checkout" page with query "productCode=EPL&sof=3501" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id    | title       | description                                     | price      |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | ฿1900      |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month |
      | EPL_2 | 7 Days      | One time charge                                 | ฿149       |
      | EPL_3 | 1 Day       | One time charge                                 | ฿119       |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    When I click "checkout_offer_[EPL_2]"
    Then I should see element "checkout_offer_[EPL_2]_selected"
    And I should see "3501" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription         |
      | ฿149         | ●3501 ||
    And I should see my truemoney "3501" balance more than 149
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I should see element "pin_div"
    When I put the value "1" in the field "pin_input_pin_digit_1"
    And I put the value "2" in the field "pin_input_pin_digit_2"
    And I put the value "3" in the field "pin_input_pin_digit_3"
    And I put the value "4" in the field "pin_input_pin_digit_4"
    And I click "pin_btn_confirm"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  Scenario: SUBSCRIBE-342 A logged trusted user should be able to purchase TVOD with TrueMoney Wallet without any verification confirm
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=J29O6r46ODmK&sof=3501" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the value "A Star Is Born" in "checkout_title"
    And I should not see element "checkout_offer_display_button"
    And I should not see element "checkout_button_termCond"
    And I should see the following items "checkout_offer"
      | id      | title               | price | description                                                                                              |
      | movie_0 | Rent a single movie | ฿59   | Movie will be kept in your library for 30 days. Enjoy unlimited viewing within 48 hours after first play |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see "3501" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription         |
      | ฿59          | ●3501 ||
    And I should see my truemoney "3501" balance more than 59
    And I should not see element "checkout_benefit"
    And I should not see element "checkout_channel"
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"

  @noparallel
  Scenario: A logged user should be able to purchase Recurring TIDPLUS successfully with Card
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=4242" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "4242" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿59/month    | ●4242     | SAMPLE BANK                   |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel @skip
  # due to unstable sub API
  Scenario: A logged user should be able to purchase 1-year OC TIDPLUS successfully with Card
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=4242" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    When I click "checkout_offer_[TIDPLUS_1]"
    Then I should see element "checkout_offer_[TIDPLUS_1]_selected"
    And I should see "4242" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿599         | ●4242     | SAMPLE BANK                   |
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected to "subscriptions" page
    And element "loading_placeholder" should be gone
    And I should see the following items "subscriptions"
      | id      | title   | status | price |
      | TIDPLUS | TrueID+ | Active | ฿599  |

  @noparallel
  Scenario: A logged user should be able to purchase EPL Best value successfully with Card
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy any offer from "EPL" before
    When I open the "checkout" page with query "productCode=EPL&sof=4242" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id    | title       | description                                     | price      |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | ฿1900      |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month |
      | EPL_2 | 7 Days      | One time charge                                 | ฿149       |
      | EPL_3 | 1 Day       | One time charge                                 | ฿119       |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    And I should see element "checkout_offer_[EPL_0]_selected"
    And I should see "4242" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription   |
      | ฿299/month   | ●4242     | SAMPLE BANK         |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  Scenario: A logged user should be able to purchase 7-day OC EPL successfully with Card
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy any offer from "EPL" before
    When I open the "checkout" page with query "productCode=EPL&sof=4242" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id    | title       | description                                     | price      |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | ฿1900      |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month |
      | EPL_2 | 7 Days      | One time charge                                 | ฿149       |
      | EPL_3 | 1 Day       | One time charge                                 | ฿119       |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    When I click "checkout_offer_[EPL_2]"
    Then I should see element "checkout_offer_[EPL_2]_selected"
    And I should see "4242" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿149         | ●4242        | SAMPLE BANK                   |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  Scenario: A logged user should be able to purchase TVOD successfully with Card
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=J29O6r46ODmK&sof=4242" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the value "A Star Is Born" in "checkout_title"
    And I should not see element "checkout_offer_display_button"
    And I should see the following items "checkout_offer"
      | id      | title               | price | description                                                                                              |
      | movie_0 | Rent a single movie | ฿59   | Movie will be kept in your library for 30 days. Enjoy unlimited viewing within 48 hours after first play |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see "4242" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿59          | ●4242     | SAMPLE BANK                   |
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"

  @noparallel
  Scenario: A logged user should be not able to purchase Recurring TIDPLUS with payment-rejected card
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=0014" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "0014" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿59/month    | ●0014     | JCB-Payment Rejected          |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    And I should not have "button_attempt" event inside dataLayer
    And I should not have "button_fail" event inside dataLayer

    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_serverError"
    And I should see the value "Unsuccessful" in "layout_placeholder_header"
    And I should see the value "Please try again" in "layout_placeholder_subheader"
    And I should see the value "Payment rejected.\n(14016)" in "layout_placeholder_detail"
    And I should have "button_attempt" event named "PaymentMethodAndPurchase" inside dataLayer
    And I should have "button_fail" event named "PaymentMethodAndPurchase" inside dataLayer

  @noparallel
  Scenario: A logged user should be able to see package rental condition
    Given I login with "TRUE_CONNECT_USER"
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    And I have made data-sharing consent
    And I have already binding "TRUE_CONNECT_USER" with "trueonline"
    And I have not verified source "trueonline"
    And I open the "sources" page
    And I click "sources_addSource_truebill"
    And I click "trueConnect_success_button"
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    And I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "0592" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿59/month    | ●0592  | TrueOnline                    |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I should see element "verifySourceModal"
    When I click "verifySourceModal_button_privacy"
    Then I should see element "sourcePrivacyCond_[FRONTEND_CMS_SOURCES_TC]_contentModal"
    And I should see element "sourcePrivacyCond_[FRONTEND_CMS_SOURCES_TC]_contentModal_title"
    And I should see element "sourcePrivacyCond_[FRONTEND_CMS_SOURCES_TC]_contentModal_detail"

  @noparallel
  @tol
  Scenario: A logged user should be able to purchase Recurring TIDPLUS with Trueonline after verified
    Given I login with "TRUE_CONNECT_USER"
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    And I never purchase via "trueonline" today
    And I have made data-sharing consent
    And I have already binding "TRUE_CONNECT_USER" with "trueonline"
    And I have not verified source "trueonline"
    And I open the "sources" page
    And I click "sources_addSource_truebill"
    And I click "trueConnect_success_button"
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=0592" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    And I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "0592" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿59/month    | ●0592  | TrueOnline                    |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I should see element "verifySourceModal"
    And I click "verifySourceModal_button_continue"
    And element "verifySourceModal" should be gone
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  @tol
  Scenario: A logged user should be able to purchase TIDPLUS successfully with verified TrueOnline
    Given I login with "TRUE_CONNECT_USER"
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    And I never purchase via "trueonline" today
    And I have made data-sharing consent
    And I have already binding "TRUE_CONNECT_USER" with "trueonline"
    And I have verified source "trueonline"
    And I open the "sources" page
    And I click "sources_addSource_truebill"
    And I click "trueConnect_success_button"
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
      | TIDPLUS_1 | 1 Year  | One time charge, Cannot cancel                 | ฿599      |
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"

  @noparallel
  Scenario: A logged user without trusted owner should not see any payment method or Truepoint and can continue redirect to sources page
    Given I login with "CONSENT_USER"
    And I never buy any offer from "EPL" before
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_offer_display_button"
    And I click "checkout_offer_[EPL_1]"
    And I click "checkout_button_continue"
    Then I am redirected match to "sources?(.*)" page

  @noparallel
  Scenario: A logged user should not see any payment method and can continue redirect to sources page
    Given I login with "LANG_USER"
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_offer_display_button"
    And I click "checkout_offer_[EPL_1]"
    And I click "checkout_button_continue"
    Then I am redirected match to "sources?(.*)" page

  @noparallel
  Scenario: A logged user without trusted owner should see payment method with truepoint (offer can pay by point)
    Given I login with "CONSENT_USER"
    And I never buy offer "EPL_EARLYBIRD2122_NPN_OC_ALA,PLNP_NPN_00_30D_ALA,EPL2021_NPN_OC_1D_ALA,EPLNP_NPN_00_7D_ALA,EPL2021_NPN_RC_EVG_ALA" before
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_paymentMethod_[truepointpoint]"

  @noparallel
  Scenario: A logged user without payment method, can see truepoint as payment method (offer can pay by point)
    Given I login with "TRUEYOU_POINT_10000_ACC_1"
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    When I click "checkout_paymentMethod_link"
    And I scroll down on "checkout_paymentMethod"
    And I should see element "checkout_paymentMethod_[truepointpoint]"

  @noparallel
  Scenario: A logged user should be able to purchase Recurring TIDPLUS successfully with TrueMoney Wallet then redirect to other page when finish
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=3501&callback=%2Frent" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I should not see element "checkout_offer_[TIDPLUS_BPN_OC_1Y_REG]"
    And I click "checkout_offer_display_button"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
    And I click "checkout_offer_display_button"
    And I should not see element "checkout_offer_[TIDPLUS_1]"
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see "3501" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription         |
      | ฿59/month    | ●3501 ||
    And I should see my truemoney "3501" balance more than 59
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected to "rent" page

  @noparallel
  Scenario: A logged user should be able to select other payment method and in correct order
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=0601" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_paymentMethod_link"
    And I should see "0601" detail in "checkout_paymentMethod" as below
      | sourceTitle  |
      | ●0601 |
    And I should not see element "checkout_paymentMethod_[MasterCard4242]_sourceTitle"
    And I click "checkout_paymentMethod_link"
    Then payment method "checkout_paymentMethod" of "TIDPLUS2_BPN_RC_EVG_REG" is in correct order
    When I click "checkout_paymentMethod_[truemoney3501]_sourceDescription"
    Then I should not see element "checkout_paymentMethod_[truemoveh0601]_sourceTitle"
    And I should see element "checkout_paymentMethod_[truemoney3501]_sourceDescription"
    And I should not see element "checkout_paymentMethod_[MasterCard4242]_sourceTitle"

  @skip
  # due to unable to show TruePoint on CI. Passed on manual test
  Scenario: A logged user should see TruePoint in payment method
    Given I login with "DEFAULT_USER_2"
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_offer_display_button"
    And I click "checkout_offer_[EPL_0]"
    Then I should see element "checkout_paymentMethod_link"
    When I click "checkout_paymentMethod_link"
    And I scroll down on "checkout_paymentMethod"
    Then I should see element "checkout_paymentMethod_[truepointpoint]"
    And I should see the value "True Points not enough" in "checkout_paymentMethod_[truepointpoint]_paymentPrice"

  Scenario: A logged user should be see each offer detail in checkout page
    Given I login with "DEFAULT_USER_2"
    When I open the "checkout" page with query "productCode=TVSNOW" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"

    #TVSNOWPREMIUM
    Then I should see element "checkout_banner"
    And I should see element "checkout_benefit"

    #TVSNOWSTD
    When I click "checkout_offer_display_button"
    And I click "checkout_offer_[TVSNOW_1]"
    Then I should see element "checkout_banner"
    And I should see element "checkout_benefit"

    #TVSNOW
    When I click "checkout_offer_display_button"
    And I click "checkout_offer_[TVSNOW_2]"
    Then I should see element "checkout_banner"
    And I should see element "checkout_benefit"

  Scenario: A logged user should be able to go to checkout with TVS offer_code
    Given I login with "DEFAULT_USER_2"
    When I open the "checkout" page with query "offer_code=TVSNOWPREMIUM_NPN_RC_EVG_ALA" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see element "checkout_offer_[TVSNOW_0]_title"
    And I should see the value "฿449/month" in "checkout_offer_[TVSNOW_0]_price"
    And I click "checkout_offer_display_button"
    And I should see element "checkout_offer_[TVSNOW_1]_title"
    And I should see the value "฿249/month" in "checkout_offer_[TVSNOW_1]_price"
    And I should see element "checkout_offer_[TVSNOW_2]_title"
    And I should see the value "฿119/month" in "checkout_offer_[TVSNOW_2]_price"

    When I open the "checkout" page with query "offer_code=TVSNOWSTD_NPN_RC_EVG_ALA2" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see element "checkout_offer_[TVSNOW_0]_title"
    And I should see the value "฿449/month" in "checkout_offer_[TVSNOW_0]_price"
    And I click "checkout_offer_display_button"
    And I should see element "checkout_offer_[TVSNOW_1]_title"
    And I should see the value "฿249/month" in "checkout_offer_[TVSNOW_1]_price"
    And I should see element "checkout_offer_[TVSNOW_2]_title"
    And I should see the value "฿119/month" in "checkout_offer_[TVSNOW_2]_price"

  Scenario: A logged user should be able to go to see the chekout for invalid offer but associate to a valid product
    Given I login with "DEFAULT_USER_2"
    When I open the "checkout" page with query "offer_code=TVSNOWPREMIUM_NPN_RC_EVG_ALA-INVALID_OFFER_NAME" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see element "checkout_offer_[TVSNOW_0]_title"
    And I should see the value "฿449/month" in "checkout_offer_[TVSNOW_0]_price"

    When I open the "checkout" page with query "offer_code=TVSNOWSTD_TRIAL1M_BPN_RC_EVG_REG3" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see element "checkout_offer_[TVSNOW_0]_title"
    And I should see the value "฿449/month" in "checkout_offer_[TVSNOW_0]_price"

    When I open the "checkout" page with query "offer_code=TVSNOWPREMIUM_TRIAL1M_BPN_RC_EVG_REG" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see element "checkout_offer_[TVSNOW_0]_title"
    And I should see the value "฿449/month" in "checkout_offer_[TVSNOW_0]_price"

  Scenario: A logged user should not be able to go to see the chekout for invalid offer
    Given I login with "DEFAULT_USER_2"
    When I open the "checkout" page with query "offer_code=INVALID_OFFER_NAME" and wait around 1 minute
    Then I should see the value "offer_code is not found\n(10003)" in "layout_placeholder_detail"

    When I open the "checkout" page with query "productCode=INVALID_OFFER_NAME" and wait around 1 minute
    Then I should see the value "offer_code is not found\n(10003)" in "layout_placeholder_detail"

  @noparallel
  Scenario: A logged user should be able to checkout package with difference TMH source
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy offer "TIDPLUS2_BPN_RC_EVG_REG,TIDPLUS_BPN_OC_1Y_REG" before
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_button_buyNow"
#   waiting for new otp modal

  @noparallel
  Scenario: SUBSCRIBE-342 A logged user should be able to purchase 1-day EPL successfully with Truepoint and pin verification
    Given I login with "TRUEMOVEH_FULL_SOURCES_USER"
    And I have setup my pin as "1234"
    And I enable purchase pincode
    And I redeem Truepoint for "TRUEMOVEH_FULL_SOURCES_USER" if point is lower than 119
    And I never buy any offer from "EPL" before
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    And I should see the following items "checkout_offer"
      | id    | title       | description                                     | price       |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | 6334 pts.   |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month  |
      | EPL_2 | 7 Days      | One time charge                                 | 179 pts.    |
      | EPL_3 | 1 Day       | One time charge                                 | 119 pts.    |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    When I click "checkout_offer_[EPL_3]"
    Then I should see element "checkout_offer_[EPL_3]_selected"
    When I click "checkout_paymentMethod_link"
    And I click "checkout_paymentMethod_[truepointpoint]"
    And I should see the value "119 pts." in "checkout_offer_[EPL_3]_price"
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I should see element "pin_div"
    When I put the value "1" in the field "pin_input_pin_digit_1"
    And I put the value "2" in the field "pin_input_pin_digit_2"
    And I put the value "3" in the field "pin_input_pin_digit_3"
    And I put the value "4" in the field "pin_input_pin_digit_4"
    And I click "pin_btn_confirm"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"

  @noparallel
  Scenario: A logged user should be not able to purchase 1-day EPL when no Truepoint
    Given I login with "DCB_ACCOUNT_PREPAID"
    And I never buy any offer from "EPL" before
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    And I should see the following items "checkout_offer"
      | id    | title       | description                                     | price       |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | 6334 pts.   |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month  |
      | EPL_2 | 7 Days      | One time charge                                 | 179 pts.    |
      | EPL_3 | 1 Day       | One time charge                                 | 119 pts.    |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    When I click "checkout_offer_[EPL_3]"
    Then I should see element "checkout_offer_[EPL_3]_selected"
    When I click "checkout_paymentMethod_link"
    Then I should see the value "True Points not enough" in "checkout_paymentMethod_[truepointpoint]_paymentPrice"
    And I click "checkout_paymentMethod_[truepointpoint]"
    And I should see the value "119 pts." in "checkout_offer_[EPL_3]_price"
    When I click "checkout_button_buyNow"
    Then I should see element "checkout_modal_truePointsWarning"

  @noparallel
  Scenario: A logged user should be not able to purchase 7-day EPL when Truepoint is not enough
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy any offer from "EPL" before
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see element "checkout_offer_display_button"
    And I click "checkout_offer_display_button"
    And I should see the following items "checkout_offer"
      | id    | title       | description                                     | price      |
      | EPL_0 | Season Pass | Buy now and watch from 10/08/2021 - 31/05/2022  | ฿1900      |
      | EPL_1 | Monthly     | You will be charged ฿299/month. Cancel anytime. | ฿299/month |
      | EPL_2 | 7 Days      | One time charge                                 | ฿149       |
      | EPL_3 | 1 Day       | One time charge                                 | ฿119       |
    And I should see element "checkout_offer_[EPL_0]_bestValue"
    When I click "checkout_offer_[EPL_3]"
    Then I should see element "checkout_offer_[EPL_3]_selected"
    When I click "checkout_paymentMethod_link"
    And I click "checkout_paymentMethod_[truepointpoint]"
    And I should see the value "119 pts." in "checkout_offer_[EPL_3]_price"
    When I click "checkout_offer_display_button"
    And I click "checkout_offer_[EPL_2]"
    Then I should see element "checkout_offer_[EPL_2]_selected"
    When I click "checkout_paymentMethod_link"
    Then I should see the value "179 pts." in "checkout_offer_[EPL_2]_price"
    And I should see the value "True Points not enough" in "checkout_paymentMethod_[truepointpoint]_paymentPrice"

  Scenario: A logged user should be able to read privacy policy as modal
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_button_privacy"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal_title"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal_detail"

  Scenario: A logged user should be able to read iQiyi privacy policy as modal
    And I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "productCode=IQIYI" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    And I click "checkout_button_privacy"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_IQIYI_CHECKOUT_PRIVACY]_contentModal"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_IQIYI_CHECKOUT_PRIVACY]_contentModal_title"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_IQIYI_CHECKOUT_PRIVACY]_contentModal_detail"

  @skip
  # due to trusted_owner property is missing 5 Jul.
  Scenario: A logged user should be able to verify TMH payment source with OTP
    And I login with "DEFAULT_UNVERIFY_USER"
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I click "checkout_paymentMethod_link"
    And I click "checkout_paymentMethod_[truemoveh0391]_sourceTitle"
    And I click "checkout_button_buyNow"
    And I should see element "trueConnectOtp_form"

  Scenario: SUBSCRIBE-25 (TIDPLUS) A non logged user should able to go to checkout and click Buy now
    Given I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute
    Then I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see element "checkout_offer_[TIDPLUS_0]_price"
    And I should see element "checkout_banner"
    And I should see element "checkout_benefit"
    And I should see element "checkout_card_highlight"
    And I should see element "checkout_button_termCond"
    And I should see element "checkout_button_privacy"
    When I click "checkout_button_privacy"
    Then I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal_title"
    And I should see element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal_detail"
    When I click "defaultModal_button_close"
    Then element "checkoutPrivacyCond_[FRONTEND_CMS_CHECKOUT_PRIVACY]_contentModal" should be gone
    And I should see element "checkout_button_buyNow"
    When I click "checkout_button_buyNow"
    Then I should see login popup

  Scenario: SUBSCRIBE-25 (EPL) A non logged user should be go to RC checkout page and click Not now
    Given I open the "checkout" page with query "productCode=EPL" and wait around 1 minute
    Then I should see element "checkout_offer_[EPL_0]_bestValue"
    And I should see element "checkout_offer_[EPL_0]_price"
    And I should see element "checkout_banner"
    And I should see element "checkout_benefit"
    And I should see element "checkout_channel"
    And I should see element "checkout_button_termCond"
    And I should see element "checkout_button_privacy"
    And I should see element "checkout_button_buyNow"
    And I should see element "checkout_button_notNow"
    When I click "checkout_button_notNow"
    Then I am redirected to "subscriptions" page
    And element "loading_placeholder" should be gone

  # no benefit for TVOD
  Scenario: SUBSCRIBE-25 (TVOD) A non logged user should be go to TVOD checkout page
    Given I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=J29O6r46ODmK" and wait around 1 minute
    Then I should see element "checkout_offer_[movie_0]_bestValue"
    And I should see element "checkout_offer_[movie_0]_price"
    And I should see element "checkout_banner"
    And I should see element "checkout_button_buyNow"
    And I should see element "checkout_button_notNow"

  Scenario: SUBSCRIBE-30 As a logged user and subscribed RC, I open checkout directly from link then I see my subscription detail
    Given I login with "DEFAULT_USER_1"
    When I open the "checkout" page with query "productCode=TVSNOWPREMIUM" and wait around 1 minute

    Then I wait around 30 seconds and should see element "subscriptionDetail_banner"
    And I should see element "subscriptionDetail_[0]_title"
    And I should see the value "฿449/month" in "subscriptionDetail_[0]_price"
    And I should see element "subscriptionDetail_banner"
    And I should see element "subscriptionDetail_benefit"
    And I should see element "subscriptionDetail_channel"
    And I should see element "subscriptionDetail_[0]_lastPaid"

  @noparallel @tol
  Scenario: SUBSCRIBE-30 As a logged user and subscribed OC, I open checkout directly from link then I see my subscription detail
    Given I login with "TRUEMOVEH_FULL_SOURCES_USER"
    And I never buy any offer from "EPL" before
    And I never purchase via "trueonline" today
    And I have made data-sharing consent
    And I have already binding "TRUEMOVEH_FULL_SOURCES_USER" with "trueonline"
    And I open the "sources" page
    And I click "sources_addSource_truebill"
    And I should see element "trueConnect_success_title"
    And I wait "2" seconds for "system refresh sources"

    And I have verified source "trueonline"
    And I have already had offer "EPLNP_NPN_00_7D_ALA" content "78Bl9M92n9m4" or I buy it with "trueonline"
    And I have already had offer "EPL2021_NPN_OC_1D_ALA" content "MQGvWbWEVDrP" or I buy it with "trueonline"
    When I open the "checkout" page with query "productCode=EPL" and wait around 1 minute

    Then I wait around 30 seconds and should see element "subscriptionDetail_banner"
    And I should see the value "7 Days" in "subscriptionDetail_[0]_title"
    And I should see element "subscriptionDetail_[0]_price"
    And I click "subscriptionDetail_subscription_display_button"
    And I should see the value "1 Day" in "subscriptionDetail_[1]_title"
    And I should see element "subscriptionDetail_[1]_price"
    And I should see element "subscriptionDetail_button_back"

  @noparallel @tol
  Scenario: SUBSCRIBE-30 As a logged user and subscribed RC & OC, I open checkout directly from link then I see my subscription detail
    Given I login with "TRUEMOVEH_FULL_SOURCES_USER"
    And I never buy any offer from "TIDPLUS" before
    And I never purchase via "trueonline" today
    And I have made data-sharing consent
    And I have already binding "TRUEMOVEH_FULL_SOURCES_USER" with "trueonline"
    And I open the "sources" page
    And I click "sources_addSource_truebill"
    And I should see element "trueConnect_success_title"
    And I wait "2" seconds for "system refresh sources"

    And I have verified source "trueonline"
    And I have already had offer "TIDPLUS_BPN_OC_1Y_REG" content "nQeRvb0k957B" or I buy it with "trueonline"
    And I have already had offer "TIDPLUS2_BPN_RC_EVG_REG" content "nQeRvb0k957B" or I buy it with "trueonline"
    When I open the "checkout" page with query "productCode=TIDPLUS" and wait around 1 minute

    Then I wait around 30 seconds and should see element "subscriptionDetail_banner"
    And I should see the value "Monthly" in "subscriptionDetail_[0]_title"
    And I should see element "subscriptionDetail_[0]_price"
    And I should not see element "subscriptionDetail_subscription_display_button"
    And I should not see element "subscriptionDetail_[1]_title"
    And I should see element "subscriptionDetail_button_back"

  Scenario: SUBSCRIBE-30, SUBSCRIBE-866 As a logged user and not subscribed, I open checkout link directly then I see checkout page
    Given I login with "DEFAULT_NEW_REGISTER_USER"
    When I open the "checkout" page with query "productCode=TVSNOW" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id         | title       | description                                                  | price      |
      | TVSNOW_0   | Now Premium | 38 Channels. You will be charged ฿449/month. Cancel anytime. | ฿449/month |
    And I should see log "[get_checkout]" in console exactly "1" time

  @noparallel @skip
  # implement on release 1.18.0 with sub v3 SUBSCRIBE-596
  Scenario: A logged user should be able to purchase iQIYI successfully with Card
    Given I login with "DEFAULT_USER_1"
    And I disable purchase pincode
    And I never setup pincode
    And I never buy any offer from "IQIYI" before
    When I open the "checkout" page with query "productCode=IQIYI&sof=4242" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id      | title       | description                                     | price      |
      | IQIYI_0 | Monthly     | You will be charged ฿119/month. Cancel anytime. | ฿119/month |
    And I should see element "checkout_offer_[IQIYI_0]_bestValue"
    And I should see element "checkout_offer_[IQIYI_0]_selected"
    And I should see "4242" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription             |
      | ฿119/month   | ●4242     | SAMPLE BANK                   |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    When I click "checkout_button_buyNow"
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "header_nav_site_link_[subscriptions]"
    Then I am redirected to "subscriptions" page
    And I wait around 30 seconds and should see element "subscriptions_container"
    And I should see the following items "subscriptions"
      | id    | title     | status | price |
      | IQIYI | iQIYI VIP | Active | ฿119  |
    When I click "subscriptions_[IQIYI]"
    And I should see element "loading_placeholder"
    And element "loading_placeholder" should be gone
    Then I should see element "subscriptionDetail_banner"
    And I should see the value "iQIYI VIP" in "subscriptionDetail_[0]_title"
    And I should see the value "฿119/month" in "subscriptionDetail_[0]_price"
    And I should see element "subscriptionDetail_banner"
    And I should see element "subscriptionDetail_benefit"
    Then I should see element "subscriptionDetail_[0]_nextDueDate"
    Then I should see element "subscriptionDetail_[0]_lastPaid"

  Scenario: SUBSCRIBE-335 (orphan TVOD) A logged user should not able to see TVOD that is invalid
    Given I login with "DEFAULT_USER_1"
    When I open the "checkout" page with query "offer_code=WARNERTVOD059_PNN_OC_30D_ALA&cms_id=8oqPlpBLbQmD" and wait around 1 minute
    Then I should see the value "The movie is not available. Please try again later.\n(400)" in "layout_placeholder_detail"

@skip
# Due to DCB return error after binding account on 4 Aug K'Nott is following up the case
  Scenario: SUBSCRIBE-342 A logged user should not be able to TIDPLUS successfully after OTP verified
    Given I login with "TRUEMOVEH_FULL_SOURCES_USER"
    And I never update my profile "me" settings
    And I never setup pincode
    And I never buy any offer from "TIDPLUS" before
    And I have verified source "trueonline"
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=0129" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "0129" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription |
      | ฿59/month    | ●0129        | TrueOnline        |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I should see element "checkout_verifyPurchase_form"
    And I should see the value "xxx-xxx-0349" in "checkout_verifyPurchase_label_4Digits"

  @noparallel
  Scenario: SUBSCRIBE-342 A logged user should see pin modal before OTP form to verify source
    Given I login with "TRUEMOVEH_FULL_SOURCES_USER"
    And I have setup my pin as "1234"
    And I enable purchase pincode
    And I never buy any offer from "TIDPLUS" before
    And I have not verified source "trueonline"
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=0441" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "0441" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription |
      | ฿59/month    | ●0441        |                   |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I should see element "pin_div"
    When I put the value "1" in the field "pin_input_pin_digit_1"
    And I put the value "2" in the field "pin_input_pin_digit_2"
    And I put the value "3" in the field "pin_input_pin_digit_3"
    And I put the value "4" in the field "pin_input_pin_digit_4"
    And I click "pin_btn_confirm"
    Then I should see element "checkout_verifySource_form"
    And I should see the value "xxx-xxx-0441" in "checkout_verifySource_label_4Digits"

  @noparallel
  Scenario: SUBSCRIBE-342 A logged user should see pin modal before source verify modal
    Given I login with "TRUEMOVEH_FULL_SOURCES_USER"
    And I have setup my pin as "1234"
    And I enable purchase pincode
    And I never buy any offer from "TIDPLUS" before
    And I have not verified source "trueonline"
    When I open the "checkout" page with query "productCode=TIDPLUS&sof=0129" and wait around 1 minute
    And I wait around 30 seconds and should see element "checkout_banner"
    Then I should see the following items "checkout_offer"
      | id        | title   | description                                    | price     |
      | TIDPLUS_0 | Monthly | You will be charged ฿59/month. Cancel anytime. | ฿59/month |
    And I should see element "checkout_offer_[TIDPLUS_0]_bestValue"
    And I should see more than 3 movies in highlight section
    And I should see "0129" detail in "checkout_paymentMethod" as below
      | paymentPrice | sourceTitle  | sourceDescription |
      | ฿59/month    | ●0129        | TrueOnline        |
    And I should see element "checkout_button_buyNow"
    And element "checkout_button_buyNow" should be enabled
    And I should see element "checkout_button_cancel"
    And element "checkout_button_cancel" should be enabled
    And I should see element "checkout_offer_[TIDPLUS_0]_selected"
    When I click "checkout_button_buyNow"
    Then I should see element "pin_div"
    When I put the value "1" in the field "pin_input_pin_digit_1"
    And I put the value "2" in the field "pin_input_pin_digit_2"
    And I put the value "3" in the field "pin_input_pin_digit_3"
    And I put the value "4" in the field "pin_input_pin_digit_4"
    And I click "pin_btn_confirm"
    Then I should see element "verifySourceModal"
    When I click "verifySourceModal_button_continue"
    Then element "verifySourceModal" should be gone
    Then I wait around 1 minute and the element "btn_loading_icon" should be gone
    And I should see element "common_placeholder_success"
    And I should see the value "Success" in "layout_placeholder_header"
    And I should see the value "You’re all set. Enjoy Watching." in "layout_placeholder_subheader"
    When I click "common_button_success"
    Then I am redirected match to "subscriptions\/(.*)" page
    And I wait around 30 seconds and should see element "subscriptionDetail_banner"
