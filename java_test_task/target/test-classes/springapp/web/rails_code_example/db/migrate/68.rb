class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :gender
      t.string :zip_code
      t.date :dob
      t.boolean :agree_toc
      t.timestamps
    end
  end
end
