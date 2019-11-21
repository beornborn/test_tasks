class User::DeleteUser
  include Interactor
  include Pundit
  include PunditHelper

  def call
    user = User.find(context.id)
    authorize user, :destroy?
    user.destroy
  end
end
