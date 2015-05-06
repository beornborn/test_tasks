class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :read
      t.integer :user_id
      t.integer :entity_id

      t.timestamps
    end
  end
end
