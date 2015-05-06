class AddBackgroundResolution1280x800 < ActiveRecord::Migration
  def up
    add_column :backgrounds, :resolution1280x800, :string
  end

  def down
  end
end
