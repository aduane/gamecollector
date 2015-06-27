require_relative '../test_helper'

class ListTest < ActiveSupport::TestCase
  should belong_to :user
  should have_many :possessions

  context "#games" do
    setup do
      @list = List.create!
      1.upto(5) do |i|
        @list.possessions.create!(gbd_id: i)
      end
    end

    should "be game objects with gbd_ids matched by the possessions for the list" do
      assert_equal @list.possessions.count, @list.games.count
      assert_equal Game.from_gbd_id(1), @list.games.first
    end

    should "take options for the possessions query" do
      assert_equal [Game.from_gbd_id(3)], @list.games(gbd_id: 3)
    end
  end
end
