class Activity::UpdateActivity
  include Interactor
  include Pundit
  include PunditHelper

  def call
    activity = Activity.find(context.id)
    authorize activity, :update?

    activity.should_update_colors = true
    activity.update!(context.params)
    context.activity = activity
  end
end
