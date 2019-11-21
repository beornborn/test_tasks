class SignupUser
  include Interactor

  def call
    context.user = User.create!(
      email: context.email,
      password: context.password,
      name: context.name,
      working_minutes: context.working_minutes,
    )
    context.user.add_role :regular
    context.token = Auth.issue({id: context.user.id})
  rescue ActiveRecord::RecordInvalid => e
    context.fail!(error: e.record.errors.as_json)
  rescue StandardError => e
    context.fail!(error: e.message)
  end
end
