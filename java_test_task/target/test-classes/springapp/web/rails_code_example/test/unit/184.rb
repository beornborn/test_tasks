require 'test_helper'

class BreakingentitysTest < ActiveSupport::TestCase

  test "should get validation error" do
     @bf = Breakingentity.new({:id=>3, :body=>"", :heading=>""})
     @bf.save
     assert @bf.new_record?
     assert_equal @bf.errors.full_messages, ["Body can't be blank", "Heading can't be blank", "Order number can't be blank"]
   end

  test "should get no validation error" do
     @bf = Breakingentity.new({:id=>3, :body=>"smth", :heading=>"smth", :order_number=>1})
     @bf.save
     assert !@bf.new_record?
     assert_equal @bf.errors.full_messages, []
   end

end
