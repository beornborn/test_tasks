class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :link_picture

      t.timestamps
    end
  end
end
