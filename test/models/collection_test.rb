require_relative '../test_helper'

class CollectionTest < ActiveSupport::TestCase
  context "Collection" do
    should "be a kind of list" do
      assert Collection.new.kind_of? List
      collection = Collection.create!
      assert_equal "Collection", collection.reload.type
    end
  end
end
