class User::GetUser
  include Interactor
  include Pundit
  include PunditHelper

  def call
    user = User.find(context.id)
    authorize user, :show?
    context.user = user
  end
end
