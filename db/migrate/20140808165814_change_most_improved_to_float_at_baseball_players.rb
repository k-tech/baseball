class ChangeMostImprovedToFloatAtBaseballPlayers < ActiveRecord::Migration
  def change
    change_column :baseball_players, :most_improved, :float
  end
end
