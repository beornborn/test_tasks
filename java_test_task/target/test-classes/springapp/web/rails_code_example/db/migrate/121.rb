class AddFieldForFollowerNotification < ActiveRecord::Migration
  def up
    add_column :users, :follow_notification_enable, :boolean
  end

  def down
  end
end
