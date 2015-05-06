class BackgroundRemove1280800 < ActiveRecord::Migration
  def up
    remove_column :backgrounds, :resolution1280x800
  end

  def down
  end
end
