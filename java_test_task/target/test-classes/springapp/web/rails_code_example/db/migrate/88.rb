class ChangeUsersColunm < ActiveRecord::Migration
  def up
    rename_column :users, :nickname_provider, :parent_nickname
  end

  def down
  end
end
