class AddAnonymousToentity < ActiveRecord::Migration
  def change
    add_column :entitys, :anonymous, :boolean
  end
end
