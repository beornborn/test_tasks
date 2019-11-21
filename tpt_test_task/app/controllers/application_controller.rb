class ApplicationController < ActionController::API
  include Pundit

  rescue_from Exception do |e|
    render json: { error: e.message }, status: 500
  end
  rescue_from ::ActiveRecord::RecordNotFound do |e|
    render json: { error: e.message }, status: 404
  end
  rescue_from Pundit::NotAuthorizedError do |e|
    render json: { error: 'Unauthorized action' }
  end
  rescue_from ::ActiveRecord::RecordInvalid do |e|
    render json: { error: e.record.errors.as_json }, status: 400
  end

  before_action :authenticate

  def current_user
    result = AuthenticateUser.call(headers: request.headers)
    @current_user ||= result.success? ? result.user : nil
  end

  private

  def authenticate
    render json: { error: 'Unauthorized user' } unless current_user
  end

  def user_not_authorized

  end
end
