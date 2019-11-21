class User::UpdateUser
  include Interactor
  include Pundit
  include PunditHelper

  def call
    user = User.find(context.id)
    authorize user, :update?
    user.update!(context.params)
    context.updated_user = user
  end
end
