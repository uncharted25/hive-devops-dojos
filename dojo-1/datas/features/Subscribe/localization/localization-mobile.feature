# Feature: Mobile multi langage support

#   @mobile @androidV2
#   Scenario: A user with TH language should see TH language even changing tab
#     Given I go to screen "landing" with user "LANG_USER"
#     When I change app language to Thai
#     And I click "com.tdcm.trueidapp.dev:id/profileWidget"
#     And I click by android nativeId "com.tdcm.trueidapp.dev:id/profileTabTextView"
#     And I click "com.tdcm.trueidapp.dev:id/profileViewPager"
#     Then I should see the value "สมาชิกแพ็กเกจ" in "sections_li_Subscriptions"

#     When I click "sections_li_Rent"
#     Then I should see the value "เช่าหนัง/ช่อง" in "sections_li_Rent"
