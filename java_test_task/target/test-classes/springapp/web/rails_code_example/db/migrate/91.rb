class CreateBreakingsentitysRatings < ActiveRecord::Migration
  def change
    create_table :breakingsentitys_ratings do |t|
      t.integer  :breakingsentity_id
      t.integer  :user_id

      t.timestamps
    end
  end
end
