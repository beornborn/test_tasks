class Activity::CreateActivity
  include Interactor
  include Pundit
  include PunditHelper

  def call
    activity = Activity.new context.params
    authorize activity, :create?

    activity.save!
    context.activity = activity
  end
end
