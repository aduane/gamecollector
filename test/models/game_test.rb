require_relative '../test_helper'

class GameTest < ActiveSupport::TestCase
  should "be created by its gbd_id" do
    assert Game.from_gbd_id(4).is_a?(Game)
  end

  should "have a gbd_id" do
    assert_equal 4, Game.from_gbd_id(4).gbd_id
  end

  should "be equal to other game objects with the same gbd_id" do
    assert_equal Game.from_gbd_id(1), Game.from_gbd_id(1)
    assert_not_equal Game.from_gbd_id(1), Game.from_gbd_id(2)
    assert_equal Game.from_gbd_id(2), Game.from_gbd_id(2)
  end

  context "the games db api methods" do
    setup do
      stub_request(:any, "thegamesdb.net/api/GetGame.php").
        with(query: {id: 1}).
        to_return(status: 200,
                  body: %{<?xml version="1.0" encoding="UTF-8" ?>
<Data>
  <Game>
    <id>1</id>
    <GameTitle>Super Awesome Game</GameTitle>
    <PlatformId>1</PlatformId>
    <Platform>Game Box</Platform>
    <ReleaseDate>01/01/2001</ReleaseDate>
    <Publisher>Games, Inc.</Publisher>
  </Game>
</Data>}
      )
      @game = Game.from_gbd_id(1)
    end
    should "include title" do
      assert_equal "Super Awesome Game", @game.title
    end

    should "include platform" do
      assert_equal "Game Box", @game.platform
    end

    should "get the title and platform from the possession if present (no api call)" do
      # possession has different data to show the source of the attributes.
      # by caching the game title and platform name, we can reduce the amount
      # of calls to the api. The data is fairly non-volatile, so I think the
      # possibility of having stale data is low. In the future, we can have
      # api calls queue a job to update the information for all users'
      # possessions of that game.
      possession = Possession.create!(gbd_id: 1, game_title: "Hello Game", game_platform: "GameGirl")

      game_with_no_possession = Game.from_gbd_id(1)
      game_with_possession = Game.from_possession(possession)

      assert_equal "Super Awesome Game", game_with_no_possession.title
      assert_equal "Game Box", game_with_no_possession.platform

      assert_equal "Hello Game", game_with_possession.title
      assert_equal "GameGirl", game_with_possession.platform
    end
  end
end
