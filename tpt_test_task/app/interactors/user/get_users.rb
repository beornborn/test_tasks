class User::GetUsers
  include Interactor
  include Pundit
  include PunditHelper

  def call
    authorize User, :list?

    context.users = policy_scope User
  end
end
