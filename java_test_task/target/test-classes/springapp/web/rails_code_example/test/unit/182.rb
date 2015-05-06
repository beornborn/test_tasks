require 'test_helper'

class BreakingentitysRatingTest < ActiveSupport::TestCase
  test "should get validation error" do
     @bfrating = BreakingentitysRating.new({:id=>2, :breakingentity_id=>1, :user_id=>2})
     @bfrating.save
     assert @bfrating.new_record?
     assert_equal @bfrating.errors.full_messages, ["Voted Already Voted"]
   end

  test "should get no validation error" do
     @bfrating = BreakingentitysRating.new({:id=>2, :breakingentity_id=>2, :user_id=>1})
     @bfrating.save
     assert !@bfrating.new_record?
     assert_equal @bfrating.errors.full_messages, []
   end
end

