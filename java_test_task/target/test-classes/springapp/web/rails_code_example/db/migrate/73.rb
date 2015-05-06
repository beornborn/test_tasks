class entityReply < ActiveRecord::Migration
  def up
    add_column :entitys, :parent_entity_id, :integer
  end

  def down
    drop_column :entitys, :parent_entity_id
  end
end
