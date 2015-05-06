class UserFbFields < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string
    add_column :users, :provider_id, :string

    add_index :users, :provider
    add_index :users, :provider_id
    add_index :users, [:provider, :provider_id]
  end

  def down
    remove_column :users, :provider
    remove_column :users, :provider_id

  end
end
