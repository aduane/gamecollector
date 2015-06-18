Feature: Collection
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
