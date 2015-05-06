class AddNicknameProvider < ActiveRecord::Migration
  def up
    add_column :users, :nickname_provider, :string
  end

  def down
  end
end
