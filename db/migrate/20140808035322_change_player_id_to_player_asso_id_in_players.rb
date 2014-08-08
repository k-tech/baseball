class ChangePlayerIdToPlayerAssoIdInPlayers < ActiveRecord::Migration
  def change
    rename_table :players, :baseball_players
  end
end
