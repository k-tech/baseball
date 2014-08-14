class RemoveBaseballPlayerIdFromBattings < ActiveRecord::Migration
  def change
    remove_column :battings, :baseball_player_id, :string
  end
end
