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
  belongs_to :baseball_player
  #def self.most_improved
    #rs = Batting.where('hits > 10 and at_bats > 10 and year_id is not null').limit(100)
    #player = {}
    #rs.each do |row|
      #player[row.player_id] = {} unless player[row.player_id].present?
      #player[row.player_id].merge!( row.year_id => row.hits / row.at_bats.to_f)
    #end

    #player.each do |key, value|
      #player[key].merge!(rate: value['2010'] - value['2009']) if value['2010'].present? and value['2009'].present?
      #Player
    #end
    #player.sort_by{|k, v| v[:rate] }
    
  #end
end
