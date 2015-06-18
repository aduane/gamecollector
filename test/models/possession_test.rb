require_relative '../test_helper'

class PossessionTest < ActiveSupport::TestCase
  should belong_to :list

  context "#game" do
    should "return a game object with the possession's gbd_id set" do
      possession = Possession.new(gbd_id: 7)
      assert_equal Game.from_gbd_id(7), possession.game
    end

    should "set itsef on the game object" do
      possession = Possession.new(gbd_id: 7)
      assert_equal possession, possession.game.possession
    end
  end
end
