class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player_id
      t.string :birth_year
      t.string :name_first
      t.string :name_last

      t.timestamps
    end
  end
end
