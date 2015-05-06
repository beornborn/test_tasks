class AddBfCommentToBf < ActiveRecord::Migration
  def change
    add_column :bf_comments, :breakingsentity_id, :integer
  end
end
