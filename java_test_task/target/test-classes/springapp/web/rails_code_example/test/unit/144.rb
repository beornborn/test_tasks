require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase

  test "should get provider name" do
    @authentication = authentications(:one)
    assert @authentication.provider_name=='Twitter'
    @authentication2 = authentications(:two)
    assert @authentication2.provider_name=='OpenID'
  end
end
