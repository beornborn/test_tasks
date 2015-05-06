class RenameBreakingentitys < ActiveRecord::Migration
  def change
      rename_table :breakingsentitys, :breakingentitys
  end
end
