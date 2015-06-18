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
    <id>112</id>
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
  end
end
