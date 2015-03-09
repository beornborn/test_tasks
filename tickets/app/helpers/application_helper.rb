module ApplicationHelper
  def login_page
    controller_name == 'user_sessions' && action_name == 'new'
  end
end
