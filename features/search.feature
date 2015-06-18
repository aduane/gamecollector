Feature: Search
  Scenario: Search with no matches
    Given there exists 0 "Mario" games
    When I sign in
    And I search for "Mario"
    Then I should see "No games matched your search."

  Scenario: Search with 5 matches
    Given there exists 5 "Mario" games
    When I sign in
    And I search for "Mario"
    Then I should see "5 games matched your search."
    And I should see "Mario 1"
    And I should see "Mario 2"
    And I should see "Mario 3"
    And I should see "Mario 4"
    And I should see "Mario 5"

  #Scenario: Add to collection from search
  #  Given there exists 1 "Zelda" games
  #  When I sign in
  #  And I view my collection
  #  Then I should see "Andrew's Collection"
  #  And I should see "There are no games in your collection"
  #  When I search for "Zelda"
  #  Then I should see "1 game matched your search."
  #  And I should see "Zelda 1"
  #  And I click to add the game to my collection
  #  Then I should see "In your Collection"
  #  And I should not see "Add to Collection"
  #  When I view my collection
  #  Then I should see "Andrew's Collection"
  #  And I should not see "There are no games in your collection"
  #  And I should see "Zelda 1"
