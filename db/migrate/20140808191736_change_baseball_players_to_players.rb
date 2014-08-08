class ChangeBaseballPlayersToPlayers < ActiveRecord::Migration
  def change
    rename_table :baseball_players, :players
  end
end
