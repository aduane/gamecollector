Feature: Collection
  Scenario: Not signed in
    When I view my collection
    Then I should see "You need to sign in for access to this page."
    And I should see "Start keeping track of your game collection."

  Scenario: No games in collection
    When I sign in
    And I view my collection
    Then I should see "Your Collection"
    And I should see "You haven't added any games yet!"

  Scenario: Five games in collection
    Given I sign in
    And I own 5 "Mario" Games
    When I view my collection
    Then I should see "Your Collection"
    And I should not see "You haven't added any games yet!"
    And I should see "Mario 1"
    And I should see "Mario 2"
    And I should see "Mario 3"
    And I should see "Mario 4"
    And I should see "Mario 5"

  Scenario: View someone else's collection while not logged in
    Given I sign in
    And I own 5 "Mario" Games
    And I log out
    When I view the collection for "Andrew"
    Then I should see "Andrew's Collection"
    And I should not see "You haven't added any games yet!"
    And I should see "Mario 1"
    And I should see "Mario 2"
    And I should see "Mario 3"
    And I should see "Mario 4"
    And I should see "Mario 5"

@javascript
  Scenario: View games by platform
    Given I sign in
    And I own 5 "Mario" Games
    When I view my collection
    And I choose to look at "Game Box 3" games
    Then I should not see "Mario 1"
    And I should not see "Mario 2"
    And I should see "Mario 3"
    And I should not see "Mario 4"
    And I should not see "Mario 5"
    When I choose to look at "Game Box 5" games
    Then I should not see "Mario 1"
    And I should not see "Mario 2"
    And I should not see "Mario 3"
    And I should not see "Mario 4"
    And I should see "Mario 5"
    When I choose to look at "All" games
    Then I should see "Mario 1"
    And I should see "Mario 2"
    And I should see "Mario 3"
    And I should see "Mario 4"
    And I should see "Mario 5"

@javascript
  Scenario: Remove game from collection
    Given I sign in
    And I own 1 "Mario" Game
    When I view my collection
    Then I should see "Your Collection"
    And I should not see "You haven't added any games yet!"
    And I should see "Mario 1"
    When I click the button to remove a game from my collection
    When I view my collection
    Then I should see "Your Collection"
    And I should not see "Mario 1"
    And I should see "You haven't added any games yet!"
