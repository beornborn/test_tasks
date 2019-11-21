class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :description
      t.date :start
      t.integer :duration
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
