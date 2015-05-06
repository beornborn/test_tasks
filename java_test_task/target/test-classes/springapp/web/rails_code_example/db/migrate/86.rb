class AddArchivalToentity < ActiveRecord::Migration
  def change
    add_column :entitys, :archive_number, :string
    add_column :entitys, :archived_at, :datetime
  end
end
