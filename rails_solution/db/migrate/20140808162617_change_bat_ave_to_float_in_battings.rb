class ChangeBatAveToFloatInBattings < ActiveRecord::Migration
  def change
    change_column :battings, :bat_ave, :float
  end
end
