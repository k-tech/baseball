class SetDefaultValueForBattings < ActiveRecord::Migration
  def up
    change_column :battings, :games_played, :integer, null: false, default: 0
    change_column :battings, :at_bats, :integer, null: false, default: 0
    change_column :battings, :runs, :integer, null: false, default: 0
    change_column :battings, :hits, :integer, null: false, default: 0
    change_column :battings, :doubles, :integer, null: false, default: 0
    change_column :battings, :triples, :integer, null: false, default: 0
    change_column :battings, :home_runs, :integer, null: false, default: 0
    change_column :battings, :runs_batted_in, :integer, null: false, default: 0
    change_column :battings, :stolen_bases, :integer, null: false, default: 0
    change_column :battings, :caught_stealing, :integer, null: false, default: 0
  end

  def down
  end
end
