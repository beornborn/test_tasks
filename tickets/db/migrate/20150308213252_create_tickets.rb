class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :email
      t.string :department
      t.string :subject
      t.text :description
      t.string :uref
      t.integer :user_id
      t.string :state

      t.timestamps
    end

    add_index :tickets, :user_id
  end
end
