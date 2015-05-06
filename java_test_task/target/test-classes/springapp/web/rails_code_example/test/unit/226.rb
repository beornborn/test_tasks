require 'test_helper'

class entityTest < ActiveSupport::TestCase

  fixtures :entitys

  def setup
    @entity = entity.new(:body=>'test')
  end

  test "should require body" do
    @entity.body = nil
    assert !@entity.valid?
    assert_not_nil @entity.errors
    assert_equal @entity.errors.full_messages, ["Body can't be blank"]
  end

  test "should unread_replies" do
    @notifications = @entity.unread_replies 1
    assert_not_nil @notifications
  end


end