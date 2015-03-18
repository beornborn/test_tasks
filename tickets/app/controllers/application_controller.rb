class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login

  private

  def not_authenticated
    redirect_to new_ticket_path
  end
end
