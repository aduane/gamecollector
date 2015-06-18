Feature: Logging in
  Scenario: I log in and see my things
    When I go to the home page
    Then I should see "Sign in"
    And I should not see "Sign out"
    And I should see "Start keeping track of your game collection."
    When I sign in
    Then I should not see "Sign in"
    And I should see "Sign out"
    And I should not see "Welcome"
    And I should not see "Start keeping track of your game collection."
    And I should see "Andrew's Collection"
