class V1::UsersController < ApplicationController
  skip_before_action :authenticate, only: :create

  def index
    result = User::GetUsers.call(user: current_user)

    if result.success?
      render json: result.users
    else
      render json: { error: result.error }
    end
  end

  def me
    render json: { user: UserSerializer.new(current_user) }
  end

  def show
    result = User::GetUser.call(user: current_user, id: params[:id])

    if result.success?
      render json: result.user
    else
      render json: { error: result.error }
    end
  end

  def create
    result = SignupUser.call(user_params)

    if result.success?
      render json: {
        user: UserSerializer.new(result.user),
        token: result.token,
      }
    else
      render json: { error: result.error }
    end
  end

  def update
    result = User::UpdateUser.call(user: current_user, id: params[:id], params: user_params)

    if result.success?
      render json: result.updated_user
    else
      render json: { error: result.error }
    end
  end

  def destroy
    result = User::DeleteUser.call(user: current_user, id: params[:id])
    render json: {}
  end

  private

  def user_params
    params.permit(:email, :password, :name, :working_minutes)
  end
end
