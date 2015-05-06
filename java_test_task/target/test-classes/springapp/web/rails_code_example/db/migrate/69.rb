class Createentitys < ActiveRecord::Migration
  def change
    create_table :entitys do |t|
      t.string :heading
      t.text :body
      t.references :user
      t.timestamps
    end
  end
end
