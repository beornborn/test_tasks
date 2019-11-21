class Activity::DeleteActivity
  include Interactor
  include Pundit
  include PunditHelper

  def call
    activity = Activity.find(context.id)
    authorize activity, :destroy?
    activity.destroy!
  end
end
