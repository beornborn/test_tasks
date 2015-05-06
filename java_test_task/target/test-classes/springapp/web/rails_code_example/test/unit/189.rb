require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
   test "should add hash to tag" do
     @cat=categories(:one)
     assert_equal @cat.hashtag, "#needaentity"
   end
end
