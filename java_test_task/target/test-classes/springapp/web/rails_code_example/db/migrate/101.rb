class AddentityVideo < ActiveRecord::Migration
  def up
    add_column :entitys, :video, :string
  end

  def down
  end
end
