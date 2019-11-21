class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :working_minutes, :role

  def role
    object.roles.last.name
  end
end
