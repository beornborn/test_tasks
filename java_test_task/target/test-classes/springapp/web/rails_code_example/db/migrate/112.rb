class AddBackgroundsResolution1152x864 < ActiveRecord::Migration
  def up
    add_column :backgrounds, :resolution1152x864, :string
  end

  def down
  end
end
