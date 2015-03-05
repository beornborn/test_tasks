class CreatePlatforms < ActiveRecord::Migration
  def up
    create_table :platforms do |t|
      t.string :name

      t.timestamps
    end
  end
end
