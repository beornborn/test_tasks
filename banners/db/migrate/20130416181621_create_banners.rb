class CreateBanners < ActiveRecord::Migration
  def up
    create_table :banners do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
