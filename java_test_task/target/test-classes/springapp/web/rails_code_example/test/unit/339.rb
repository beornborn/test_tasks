require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:two)
  end

  test "should create user" do
    @user2 = User.create(:confirmed_at => DateTime.now, :name=>'testname', :user_name=>'tusername', :acceptance => true, :gender=>"Male", :email=>"test@test.test", :password=>"password", :password_confirmation=>"password", :dob=>"11/11/1111")
    assert @user2.valid?
  end

  test "should not pass validation" do
    @user2 = User.new(:name=>'', :gender=>"", :user_name=>'', :acceptance => false,  :email=>"", :password=>"", :password_confirmation=>"password")
    @user2.save
    assert @user2.new_record?
    assert_equal @user2.errors.full_messages, ["Name can't be blank", "User name can't be blank", "Email can't be blank", "Email is invalid", "Password can't be blank", "Gender can't be blank", "Dob can't be blank"]
  end

  #should update signed request
  test "should apply facebook" do
    #    reply = FacebookAuthentication::parse_signed_request("MA-fYxIBVUWqRHPahUA2ANkmyIiybno4jAieokfEToI.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzE3MzcyMDAsImlzc3VlZF9hdCI6MTMzMTczMzE3NSwib2F1dGhfdG9rZW4iOiJBQUFEcUxFV2hWdlFCQUVKRjhOamlzUjdEdkdYb21LQ1pCWUpHUTRnVjRDZE5KdWZsaW1YYkpGNXZYVFV3eGc1N3M5WkNlRWdtOHA5WE1pQk1KU2J2d0M2WkFaQm50R3daQkRGeVU1WkFQUmNOSGxwS2szeXFueiIsInJlZ2lzdHJhdGlvbiI6eyJuYW1lIjoiT2xlZyBHb3JidW5vdiIsImVtYWlsIjoiYmVvcm5ib3JuXHUwMDQwZ21haWwuY29tIiwibG9jYXRpb24iOnsibmFtZSI6Ilx1MDQyMVx1MDQzOFx1MDQzY1x1MDQ0NFx1MDQzNVx1MDQ0MFx1MDQzZVx1MDQzZlx1MDQzZVx1MDQzYlx1MDQ0YyIsImlkIjoyMDEzNzE2MjY1NzI5MTd9LCJnZW5kZXIiOiJtYWxlIiwidXNlcl9uYW1lIjoicXdlcXdlcXdlIn0sInJlZ2lzdHJhdGlvbl9tZXRhZGF0YSI6eyJmaWVsZHMiOiJbXG4gIHsnbmFtZSc6J25hbWUnfSxcbiAgeyduYW1lJzonZW1haWwnfSxcbiAgeyduYW1lJzonbG9jYXRpb24nfSxcbiAgeyduYW1lJzonZ2VuZGVyJ30sXG4gIHsnbmFtZSc6J3VzZXJfbmFtZScsICAgICAgJ2Rlc2NyaXB0aW9uJzonVXNlciBuYW1lIGZvciBGaWJzJywgICAgICAgICAgICAgJ3R5cGUnOid0ZXh0J30sXG4gIF0ifSwidXNlciI6eyJjb3VudHJ5IjoidWEiLCJsb2NhbGUiOiJydV9SVSJ9LCJ1c2VyX2lkIjoiMTAwMDAxMTY1MjkyMjQ5In0", ENV["FACEBOOK_APP_SECRET"] || "e3184262714695fc0af73abe85da9ae4")
    #    user = User.apply_facebook(reply["registration"], reply["user_id"])
    #    assert_equal user.name, "Oleg Gorbunov"
  end
  
  #should update signed request
  test "should apply twitter" do
    #    reply = FacebookAuthentication::parse_signed_request("MA-fYxIBVUWqRHPahUA2ANkmyIiybno4jAieokfEToI.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzE3MzcyMDAsImlzc3VlZF9hdCI6MTMzMTczMzE3NSwib2F1dGhfdG9rZW4iOiJBQUFEcUxFV2hWdlFCQUVKRjhOamlzUjdEdkdYb21LQ1pCWUpHUTRnVjRDZE5KdWZsaW1YYkpGNXZYVFV3eGc1N3M5WkNlRWdtOHA5WE1pQk1KU2J2d0M2WkFaQm50R3daQkRGeVU1WkFQUmNOSGxwS2szeXFueiIsInJlZ2lzdHJhdGlvbiI6eyJuYW1lIjoiT2xlZyBHb3JidW5vdiIsImVtYWlsIjoiYmVvcm5ib3JuXHUwMDQwZ21haWwuY29tIiwibG9jYXRpb24iOnsibmFtZSI6Ilx1MDQyMVx1MDQzOFx1MDQzY1x1MDQ0NFx1MDQzNVx1MDQ0MFx1MDQzZVx1MDQzZlx1MDQzZVx1MDQzYlx1MDQ0YyIsImlkIjoyMDEzNzE2MjY1NzI5MTd9LCJnZW5kZXIiOiJtYWxlIiwidXNlcl9uYW1lIjoicXdlcXdlcXdlIn0sInJlZ2lzdHJhdGlvbl9tZXRhZGF0YSI6eyJmaWVsZHMiOiJbXG4gIHsnbmFtZSc6J25hbWUnfSxcbiAgeyduYW1lJzonZW1haWwnfSxcbiAgeyduYW1lJzonbG9jYXRpb24nfSxcbiAgeyduYW1lJzonZ2VuZGVyJ30sXG4gIHsnbmFtZSc6J3VzZXJfbmFtZScsICAgICAgJ2Rlc2NyaXB0aW9uJzonVXNlciBuYW1lIGZvciBGaWJzJywgICAgICAgICAgICAgJ3R5cGUnOid0ZXh0J30sXG4gIF0ifSwidXNlciI6eyJjb3VudHJ5IjoidWEiLCJsb2NhbGUiOiJydV9SVSJ9LCJ1c2VyX2lkIjoiMTAwMDAxMTY1MjkyMjQ5In0", ENV["FACEBOOK_APP_SECRET"] || "e3184262714695fc0af73abe85da9ae4")
    #    user = User.apply_facebook(reply["registration"], reply["user_id"])
    #    assert_equal user.name, "Oleg Gorbunov"
  end

  #should update signed request
  test "should apply omniauth" do
    #    reply = FacebookAuthentication::parse_signed_request("MA-fYxIBVUWqRHPahUA2ANkmyIiybno4jAieokfEToI.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImV4cGlyZXMiOjEzMzE3MzcyMDAsImlzc3VlZF9hdCI6MTMzMTczMzE3NSwib2F1dGhfdG9rZW4iOiJBQUFEcUxFV2hWdlFCQUVKRjhOamlzUjdEdkdYb21LQ1pCWUpHUTRnVjRDZE5KdWZsaW1YYkpGNXZYVFV3eGc1N3M5WkNlRWdtOHA5WE1pQk1KU2J2d0M2WkFaQm50R3daQkRGeVU1WkFQUmNOSGxwS2szeXFueiIsInJlZ2lzdHJhdGlvbiI6eyJuYW1lIjoiT2xlZyBHb3JidW5vdiIsImVtYWlsIjoiYmVvcm5ib3JuXHUwMDQwZ21haWwuY29tIiwibG9jYXRpb24iOnsibmFtZSI6Ilx1MDQyMVx1MDQzOFx1MDQzY1x1MDQ0NFx1MDQzNVx1MDQ0MFx1MDQzZVx1MDQzZlx1MDQzZVx1MDQzYlx1MDQ0YyIsImlkIjoyMDEzNzE2MjY1NzI5MTd9LCJnZW5kZXIiOiJtYWxlIiwidXNlcl9uYW1lIjoicXdlcXdlcXdlIn0sInJlZ2lzdHJhdGlvbl9tZXRhZGF0YSI6eyJmaWVsZHMiOiJbXG4gIHsnbmFtZSc6J25hbWUnfSxcbiAgeyduYW1lJzonZW1haWwnfSxcbiAgeyduYW1lJzonbG9jYXRpb24nfSxcbiAgeyduYW1lJzonZ2VuZGVyJ30sXG4gIHsnbmFtZSc6J3VzZXJfbmFtZScsICAgICAgJ2Rlc2NyaXB0aW9uJzonVXNlciBuYW1lIGZvciBGaWJzJywgICAgICAgICAgICAgJ3R5cGUnOid0ZXh0J30sXG4gIF0ifSwidXNlciI6eyJjb3VudHJ5IjoidWEiLCJsb2NhbGUiOiJydV9SVSJ9LCJ1c2VyX2lkIjoiMTAwMDAxMTY1MjkyMjQ5In0", ENV["FACEBOOK_APP_SECRET"] || "e3184262714695fc0af73abe85da9ae4")
    #    user = User.apply_facebook(reply["registration"], reply["user_id"])
    #    assert_equal user.name, "Oleg Gorbunov"
  end

  test "check reserve_name" do
    @user.reserve_name
    assert_equal ["User name has already been taken"], @user.errors.full_messages
  end


  test "check gender_value" do
    @user.gender_value
    assert_equal ["Gender can't be blank"], @user.errors.full_messages
  end

  test "check default notifications options" do
    @user.default_notification_options
    assert_equal true, @user.comment_notification_enable
    assert_equal true, @user.product_notification_enable
    assert_equal true, @user.account_product_notification_enable
  end

  test "check dob_date_syntax" do
    @user.dob_date_syntax
    assert_equal [],@user.errors.full_messages
    @user.dob=nil
    @user.dob_date_syntax
    assert_equal ["Dob can't be blank"], @user.errors.full_messages
    @user.errors.clear
    @user.dob="9.30.1989"
    @user.dob_date_syntax
    assert_equal ["Dob should be in mm/dd/yyyy format"], @user.errors.full_messages
    @user.errors.clear
    @user.dob="09/09/2001"
    @user.dob_date_syntax
    assert_equal ["Dob You are not of legal age to use this site"], @user.errors.full_messages
  end

  test "should crop name" do
    @user.name = "david duhovny"
    assert_equal @user.crop_name, "david D"
  end

end
