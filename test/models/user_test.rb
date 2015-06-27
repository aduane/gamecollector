require_relative '../test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.create_with_omniauth({'provider' => 'test', 'uid' => 1, 'info' => {'name' => 'test user'}})
  end

  context "a users collection" do
    should "be created if not found" do
      assert 0, Collection.count
      @user.collection
      # not found, created
      assert 1, Collection.count
      @user.collection
      # found, nothing created
      assert 1, Collection.count
    end
  end

  context "#owned_games" do
    setup do
      @user.add_to_collection(7, "Fun Game", "Gamebox")
      @user.add_to_collection(6, "Cool Game", "Gamebox pocket")
    end

    should "be the games in a user's collection" do
      assert_equal @user.collection.games, @user.owned_games 
    end

    should "take options for the query on possessions" do
      assert_equal [Game.from_gbd_id(6)], @user.owned_games(game_platform: "Gamebox pocket")
    end
  end

  context "#add_to_collection" do
    should "create a possession for the user's collection with the given gbd_id" do
      assert_equal 0, @user.collection.possessions.where(gbd_id: 7).count
      @user.add_to_collection(7)
      assert_equal 1, @user.collection.possessions.where(gbd_id: 7).count
    end

    should "store some game information to reduce api calls" do
      @user.add_to_collection(7, "Fun Game", "Gamebox")
      assert_equal "Fun Game", Possession.last.game_title
      assert_equal "Gamebox", Possession.last.game_platform
    end
  end

  context "#remove_from_collection" do
    setup do
      @user.add_to_collection(7, "Fun Game", "Gamebox")
    end

    should "destroy any possesions matching the user's collection and the given gbd_id" do
      assert_equal 1, Possession.where(list_id: @user.collection.id, gbd_id: 7).count
      @user.remove_from_collection(7)
      assert_equal 0, Possession.where(list_id: @user.collection.id, gbd_id: 7).count
    end
  end

  context "#owns_game?" do
    should "return true if the given game is in the set of the user's owned_games" do
      game1 = Game.from_gbd_id(7)
      game2 = Game.from_gbd_id(8)
      @user.add_to_collection(7, "Fun Game", "Gamebox")
      assert !@user.owns_game?(game2)
      assert @user.owns_game?(game1)
    end
  end
end
