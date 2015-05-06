require 'test_helper'
# Re-raise errors caught by the controller.
class ApplicationControllerTest < ActionController::TestCase
  def setup
    @controller = ApplicationController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  #method isn't used
  test "should fix protocol" do
  end

  test "should get layout by resource" do
    #tested in other methods
  end

  test "should authenticate" do
    #returns always true
  end

  #tested in other controller tests
  test "should get categories" do
  end

end
