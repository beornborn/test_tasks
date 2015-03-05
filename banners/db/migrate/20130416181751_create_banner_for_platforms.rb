class CreateBannerForPlatforms < ActiveRecord::Migration
  def up
    create_table :banner_for_platforms do |t|
      t.references :banner
      t.references :platform
      t.integer :max_views, :default => 5
      t.integer :amount_views, :default => 0
      t.integer :amount_clicks, :default => 0
      t.boolean :default, :default => false

      t.timestamps
    end
    add_index :banner_for_platforms, :banner_id
    add_index :banner_for_platforms, :platform_id
  end
end
