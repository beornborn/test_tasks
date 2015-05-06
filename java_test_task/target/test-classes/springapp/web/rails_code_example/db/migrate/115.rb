class AddOrderFieldForentityWorthy < ActiveRecord::Migration
  def up
    add_column :breakingentitys, :order_number, :integer
  end

  def down
  end
end
