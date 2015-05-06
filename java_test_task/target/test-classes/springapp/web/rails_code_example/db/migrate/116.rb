class AddUrlFieldsForBackground < ActiveRecord::Migration
  def up
    add_column :backgrounds, :url1366x768, :string
    add_column :backgrounds, :url1280x1024, :string
    add_column :backgrounds, :url1440x900, :string
    add_column :backgrounds, :url1920x1080, :string
    add_column :backgrounds, :url1024x768, :string
    add_column :backgrounds, :url1600x900, :string
    add_column :backgrounds, :url2560x1440, :string
    add_column :backgrounds, :url1280x800, :string
    add_column :backgrounds, :url1152x864, :string
  end

  def down
  end
end
