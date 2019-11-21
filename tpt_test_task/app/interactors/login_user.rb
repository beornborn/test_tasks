class LoginUser
  include Interactor

  def call
    user = User.find_by(email: context.email)

    unless user && user.valid_password?(context.password)
      context.fail!(error: 'Invalid credentials')
    end

    context.token = Auth.issue({id: user.id})
    context.user = user
  end
end
