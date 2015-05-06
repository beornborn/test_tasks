class AddBackgroundResolution2560x1920 < ActiveRecord::Migration
  def up
    add_column :backgrounds, :resolution2560x1920, :string
  end

  def down
  end
end
