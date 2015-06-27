Feature: Collection
  Scenario: Not signed in
    When I view my collection
    Then I should see "You need to sign in for access to this page."
    And I should see "Start keeping track of your game collection."

  Scenario: No games in collection
    When I sign in
    And I view my collection
    Then I should see "Andrew's Collection"
    And I should see "There are no games in your collection"

  Scenario: Five games in collection
    Given I sign in
    And I own 5 "Mario" Games
    When I view my collection
    Then I should see "Andrew's Collection"
    And I should not see "There are no games in your collection"
    And I should see "Mario 1"
    And I should see "Mario 2"
    And I should see "Mario 3"
    And I should see "Mario 4"
    And I should see "Mario 5"

@javascript
  Scenario: Remove game from collection
    Given I sign in
    And I own 1 "Mario" Game
    When I view my collection
    Then I should see "Andrew's Collection"
    And I should not see "There are no games in your collection"
    And I should see "Mario 1"
    When I click the button to remove a game from my collection
    When I view my collection
    Then I should see "Andrew's Collection"
    And I should not see "Mario 1"
    And I should see "There are no games in your collection"
