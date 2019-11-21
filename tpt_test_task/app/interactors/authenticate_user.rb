class AuthenticateUser
  include Interactor

  def call
    payload = Auth.decode(context.headers['X-AUTH-TOKEN']).first
    context.user = User.find(payload['id'])
  rescue StandardError => e
    context.fail!
  end
end
