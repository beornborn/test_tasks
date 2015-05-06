class RemoveRatesFromentitysRating < ActiveRecord::Migration
  def up
    remove_column :entitys_ratings, :rated
  end

  def down
  end
end
