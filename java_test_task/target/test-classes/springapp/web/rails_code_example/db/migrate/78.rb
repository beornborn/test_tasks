class ChangeDob < ActiveRecord::Migration
  def up
	change_column :users, :dob, :string
  end

  def down
  end
end
