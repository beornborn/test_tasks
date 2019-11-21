class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :crypted_password
      t.string :salt
      t.integer :working_minutes

      t.timestamps
    end
  end
end
