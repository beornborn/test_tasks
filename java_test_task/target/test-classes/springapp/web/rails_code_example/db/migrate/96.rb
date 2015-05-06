class RenameBreakingentitysRating < ActiveRecord::Migration
  def change
    rename_table :breakingsentitys_ratings, :breakingentitys_ratings
  end
end
