# == Schema Information
#
# Table name: battings
#
#  id              :integer          not null, primary key
#  player_id       :string(255)
#  year_id         :string(255)
#  league          :string(255)
#  team_id         :string(255)
#  games_played    :integer
#  at_bats         :integer
#  runs            :integer
#  hits            :integer
#  doubles         :integer
#  triples         :integer
#  home_runs       :integer
#  runs_batted_in  :integer
#  stolen_bases    :integer
#  caught_stealing :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Batting < ActiveRecord::Base
end
