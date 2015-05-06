require 'test_helper'

class BackgroundTest < ActiveSupport::TestCase
   test "should url fix" do
     @background = backgrounds(:one)
     @background.url_fix
     assert_equal "http://google.com", @background.url
     @background = backgrounds(:two)
     @background.url_fix
     assert_equal  "http://www.google.com", @background.url
   end
end
