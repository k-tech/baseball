class AddMostImprovedToBaseballPlayers < ActiveRecord::Migration
  def change
    add_column :baseball_players, :most_improved, :integer
  end
end
