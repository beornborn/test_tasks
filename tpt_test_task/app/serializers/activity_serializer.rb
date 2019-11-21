class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :description, :start, :duration, :user_id, :color

  belongs_to :user
end
