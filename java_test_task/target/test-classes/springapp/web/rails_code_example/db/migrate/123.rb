class AddFollowNotificationToken < ActiveRecord::Migration
  def up
    add_column :users, :follow_notification_token, :string
  end

  def down
  end
end
