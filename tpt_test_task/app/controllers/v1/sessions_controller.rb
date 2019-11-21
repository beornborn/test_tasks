class V1::SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    result = LoginUser.call(login_params)

    if result.success?
      render json: {
        user: UserSerializer.new(result.user),
        token: result.token,
      }
    else
      render json: { error: result.error }
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
