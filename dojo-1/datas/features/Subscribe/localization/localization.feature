@noparallel
Feature: Multi langage support

  @CustomBrowser
  Scenario: A user with EN language should see have EN as default language
    Given I login with "LANG_USER"
    And I never update my profile "me" settings
    And User open browser with language is set to "en"
    When I open the "subscriptions" page
    Then I should see the menu as follows
      | header        | content       |
      | Subscriptions | Subscriptions |
      | Rent          | Rent          |
      | Promo Code    | Promo Code    |
      | Purchases     | Purchases     |
    And I should see the site menu as follows
      | menu                 | content       |
      | site_[home]          |               |
      | site_[tv]            | TV            |
      | site_[movies]        | Movies/Series |
      | site_[news]          | News          |
      | site_[sport]         | Sport         |
      | site_[privilege]     | Privilege     |
      | site_[entertainment] | Entertainment |
      | site_[music]         | Music         |
      | site_[horoscope]     | Horoscope     |
      | site_[travel]        | Travel        |
      | site_[food]          | Food          |
      | site_[women]         | Women         |
      | site_[trend]         | In-Trend      |
      | site_[subscriptions] | Package       |
      | site_[ott]           | TrueID TV Box |
    When I open the "security" page
    Then I should see the menu as follows
      | header           | content          |
      | Security & login | Security & login |
      | Devices          | Devices          |
      | Apps             | Apps             |

  @CustomBrowser
  Scenario: A user with TH language should see have TH as default language
    Given I login with "LANG_USER"
    And I never update my profile "me" settings
    And User open browser with language is set to "th"
    When I open the "subscriptions" page
    Then I should see the menu as follows
      | header        | content        |
      | Subscriptions | สมาชิกแพ็กเกจ  |
      | Rent          | เช่าหนัง/ช่อง  |
      | Promo Code    | รหัสโปรโมชั่น  |
      | Purchases     | ประวัติการซื้อ |
    And I should see the site menu as follows
      | menu                 | content           |
      | site_[home]          |                   |
      | site_[tv]            | ดูทีวีออนไลน์     |
      | site_[movies]        | ดูหนัง/ซีรีส์     |
      | site_[news]          | ข่าว              |
      | site_[sport]         | กีฬา              |
      | site_[privilege]     | สิทธิพิเศษ        |
      | site_[entertainment] | บันเทิงดารา       |
      | site_[music]         | เพลง              |
      | site_[horoscope]     | ดูดวง             |
      | site_[travel]        | ท่องเที่ยว        |
      | site_[food]          | อาหาร             |
      | site_[women]         | ผู้หญิง           |
      | site_[trend]         | อินเทรนด์         |
      | site_[subscriptions] | แพ็กเกจ           |
      | site_[ott]           | กล่องทรูไอดี ทีวี |
    When I open the "security" page
    Then I should see the menu as follows
      | header           | content                      |
      | Security & login | ความปลอดภัย & การเข้าสู่ระบบ |
      | Devices          | อุปกรณ์                      |
      | Apps             | แอปพลิเคชัน                  |

  Scenario: A user identify language to EN and should have EN language
    Given I login with "LANG_USER"
    When I open the "subscriptions" page
    Then I should see the menu as follows
      | header        | content       |
      | Subscriptions | Subscriptions |
      | Rent          | Rent          |
      | Promo Code    | Promo Code    |
      | Purchases     | Purchases     |
    And I should see the site menu as follows
      | menu                 | content       |
      | site_[home]          |               |
      | site_[tv]            | TV            |
      | site_[movies]        | Movies/Series |
      | site_[news]          | News          |
      | site_[sport]         | Sport         |
      | site_[privilege]     | Privilege     |
      | site_[entertainment] | Entertainment |
      | site_[music]         | Music         |
      | site_[horoscope]     | Horoscope     |
      | site_[travel]        | Travel        |
      | site_[food]          | Food          |
      | site_[women]         | Women         |
      | site_[trend]         | In-Trend      |
      | site_[subscriptions] | Package       |
      | site_[ott]           | TrueID TV Box |
    When I open the "security" page
    Then I should see the menu as follows
      | header           | content          |
      | Security & login | Security & login |
      | Devices          | Devices          |
      | Apps             | Apps             |

  Scenario: A user identify language to TH and should have TH language
    Given I login with "LANG_USER"
    When I open the "th/subscriptions" page
    Then I should see the menu as follows
      | header        | content        |
      | Subscriptions | สมาชิกแพ็กเกจ  |
      | Rent          | เช่าหนัง/ช่อง  |
      | Promo Code    | รหัสโปรโมชั่น  |
      | Purchases     | ประวัติการซื้อ |
    And I should see the site menu as follows
      | menu                 | content           |
      | site_[home]          |                   |
      | site_[tv]            | ดูทีวีออนไลน์     |
      | site_[movies]        | ดูหนัง/ซีรีส์     |
      | site_[news]          | ข่าว              |
      | site_[sport]         | กีฬา              |
      | site_[privilege]     | สิทธิพิเศษ        |
      | site_[entertainment] | บันเทิงดารา       |
      | site_[music]         | เพลง              |
      | site_[horoscope]     | ดูดวง             |
      | site_[travel]        | ท่องเที่ยว        |
      | site_[food]          | อาหาร             |
      | site_[women]         | ผู้หญิง           |
      | site_[trend]         | อินเทรนด์         |
      | site_[subscriptions] | แพ็กเกจ           |
      | site_[ott]           | กล่องทรูไอดี ทีวี |
    When I open the "th/security" page
    Then I should see the menu as follows
      | header           | content                      |
      | Security & login | ความปลอดภัย & การเข้าสู่ระบบ |
      | Devices          | อุปกรณ์                      |
      | Apps             | แอปพลิเคชัน                  |

  Scenario: A user who has display language setting as EN should have EN language
    Given I login with "LANG_USER"
    And I change my profile "me" display language to "en"
    When I open the "subscriptions" page
    Then I should see the menu as follows
      | header        | content       |
      | Subscriptions | Subscriptions |
      | Rent          | Rent          |
      | Promo Code    | Promo Code    |
      | Purchases     | Purchases     |
    And I should see the site menu as follows
      | menu                 | content       |
      | site_[home]          |               |
      | site_[tv]            | TV            |
      | site_[movies]        | Movies/Series |
      | site_[news]          | News          |
      | site_[sport]         | Sport         |
      | site_[privilege]     | Privilege     |
      | site_[entertainment] | Entertainment |
      | site_[music]         | Music         |
      | site_[horoscope]     | Horoscope     |
      | site_[travel]        | Travel        |
      | site_[food]          | Food          |
      | site_[women]         | Women         |
      | site_[trend]         | In-Trend      |
      | site_[subscriptions] | Package       |
      | site_[ott]           | TrueID TV Box |
    When I open the "security" page
    Then I should see the menu as follows
      | header           | content          |
      | Security & login | Security & login |
      | Devices          | Devices          |
      | Apps             | Apps             |

  @skip
  Scenario: A user who has display language setting as TH should have TH language
    Given I login with "LANG_USER"
    And I change my profile "me" display language to "th"
    When I open the "subscriptions" page
    Then I should see the menu as follows
      | header        | content        |
      | Subscriptions | สมาชิกแพ็กเกจ  |
      | Rent          | เช่าหนัง/ช่อง  |
      | Promo Code    | รหัสโปรโมชั่น  |
      | Purchases     | ประวัติการซื้อ |
    And I should see the site menu as follows
      | menu                 | content           |
      | site_[home]          |                   |
      | site_[tv]            | ดูทีวีออนไลน์     |
      | site_[movies]        | ดูหนัง/ซีรีส์     |
      | site_[news]          | ข่าว              |
      | site_[sport]         | กีฬา              |
      | site_[privilege]     | สิทธิพิเศษ        |
      | site_[entertainment] | บันเทิงดารา       |
      | site_[music]         | เพลง              |
      | site_[horoscope]     | ดูดวง             |
      | site_[travel]        | ท่องเที่ยว        |
      | site_[food]          | อาหาร             |
      | site_[women]         | ผู้หญิง           |
      | site_[trend]         | อินเทรนด์         |
      | site_[subscriptions] | แพ็กเกจ           |
      | site_[ott]           | กล่องทรูไอดี ทีวี |
    When I open the "security" page
    Then I should see the menu as follows
      | header           | content                      |
      | Security & login | ความปลอดภัย & การเข้าสู่ระบบ |
      | Devices          | อุปกรณ์                      |
      | Apps             | แอปพลิเคชัน                  |
    And I change my profile "me" display language to "en"
