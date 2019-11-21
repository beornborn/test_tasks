class Activity::GetActivity
  include Interactor
  include Pundit
  include PunditHelper

  def call
    activity = Activity.find(context.id)
    authorize activity, :show?
    context.activity = activity
  end
end
