class CreateFollowRelations < ActiveRecord::Migration
  def up
    create_table :follow_relations do |t|
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
