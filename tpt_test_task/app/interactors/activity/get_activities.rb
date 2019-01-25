class Activity::GetActivities
  include Interactor
  include Pundit
  include PunditHelper

  def call
    authorize Activity, :list?
    scope = policy_scope Activity

    params = context.params || {}
    scope = scope.where('start >= ?', params[:start]) if (params[:start])
    scope = scope.where('start <= ?', params[:end]) if (params[:end])

    context.activities = scope.includes(user: :roles).order(id: :desc)
  end
end
