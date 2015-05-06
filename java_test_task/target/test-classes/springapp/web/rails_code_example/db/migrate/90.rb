class CreateBfComments < ActiveRecord::Migration
  def change
    create_table :bf_comments do |t|
      t.string   :heading
      t.text     :body
      t.integer  :user_id
      t.boolean  :anonymous

      t.timestamps
    end
  end
end
