class V1::ActivitiesController < ApplicationController
  def index
    result = Activity::GetActivities.call(user: current_user, params: params)

    if result.success?
      render json: result.activities
    else
      render json: { error: result.error }
    end
  end

  def show
    result = Activity::GetActivity.call(user: current_user, id: params[:id])

    if result.success?
      render json: result.activity
    else
      render json: { error: result.error }
    end
  end

  def create
    result = Activity::CreateActivity.call(user: current_user, params: activity_params)

    if result.success?
      render json: result.activity
    else
      render json: { error: result.error }
    end
  end

  def update
    result = Activity::UpdateActivity.call(user: current_user, id: params[:id], params: activity_update_params)

    if result.success?
      render json: result.activity
    else
      render json: { error: result.error }
    end
  end

  def destroy
    result = Activity::DeleteActivity.call(user: current_user, id: params[:id])
    render json: {}
  end

  private

  def activity_params
    params.permit(:description, :start, :duration, :user_id)
  end

  def activity_update_params
    params.permit(:description, :start, :duration)
  end
end
