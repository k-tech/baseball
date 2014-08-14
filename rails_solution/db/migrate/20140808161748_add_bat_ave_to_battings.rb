class AddBatAveToBattings < ActiveRecord::Migration
  def change
    add_column :battings, :bat_ave, :integer
  end
end
