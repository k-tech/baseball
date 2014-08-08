class AddBaseballPlayerIdToBattings < ActiveRecord::Migration
  def change
    add_column :battings, :baseball_player_id, :integer
  end
end
