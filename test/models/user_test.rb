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
    should "be the games in a user's collection" do
      assert_equal @user.collection.games, @user.owned_games 
    end
  end

  context "#add_to_collection" do
    should "create a possession for the user's collection with the given gbd_id" do
      assert_equal 0, @user.collection.possessions.where(gbd_id: 7).count
      @user.add_to_collection(7)
      assert_equal 1, @user.collection.possessions.where(gbd_id: 7).count
    end
  end
end
