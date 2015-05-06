class RenameBreakingentitysColumnInComments < ActiveRecord::Migration
  def change
    rename_column :bf_comments, :breakingsentity_id, :breakingentity_id
  end
end
