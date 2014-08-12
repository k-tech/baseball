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
  belongs_to :player, primary_key: :player_id, foreign_key: :player_id

  default_scope -> {where("hits is not null and runs is not null and doubles is not null and triples is not null and home_runs is not null and at_bats is not null")}
  scope :slugging_condition, -> {where("hits is not null and runs is not null and doubles is not null and triples is not null and home_runs is not null and at_bats is not null")}
  scope :batting_ave_condition, -> {where("at_bats >= 200")}
  scope :year_league_winners, ->(year, league, spec) { self.where(year_id: year, league: league).where('at_bats >= 400').where(spec => self.best_score(year, league, spec)) }

  delegate :full_name, to: :player, prefix: true

  def self.get_slugging 
    rs = self.slugging_condition.where(team_id: 'OAK', year_id: '2007')
    rs.map{|b| slugging = ((b.hits.to_f - b.doubles.to_f - b.triples.to_f - b.home_runs.to_f) + (2 * b.doubles.to_f) + (3 * b.triples.to_f) + (4 * b.home_runs.to_f)) / b.at_bats.to_f if b.at_bats != 0; slugging}.compact
  end

  def self.get_most_improved
    #@first = self.batting_ave_condition.group(:player_id).where(year_id: '2009').select('id', 'player_id', 'hits / at_bats as bat_ave')
    #@second = self.batting_ave_condition.group(:player_id).where(year_id: '2010').select('id', 'player_id', 'hits / at_bats as bat_ave')
    byebug
    
  end

  def self.best_score(year, league, spec)
    self.where(year_id: year, league: league).where('at_bats > 400').maximum(spec)
  end

  def self.triple_crown_winner(year, league)
    winners = %w(runs_batted_in bat_ave).inject(year_league_winners(year, league, 'home_runs')) do |rs, spec|
      rs &= year_league_winners(year, league, spec)
    end
    winners.empty? ? 'No Winner' : winners.map(&:player_full_name).join(', ')
  end

  def self.most_improved
    rs = Batting.all
    player = {}
    rs.each do |row|
      unless (row.hits == 0) or (row.at_bats == 0)
        player[row.player_id] = {} unless player[row.player_id].present? 
        player[row.player_id].merge!( row.year_id => row.hits.to_f / row.at_bats.to_f)
      end
    end

    player.each do |key, value|
      player[key].merge!(rate: value['2010'] - value['2009']) if value['2010'].present? and value['2009'].present?
    end
    player = player.delete_if{|key, value| value['2010'].blank? or value['2009'].blank?}
    player.sort_by{|k, v| v[:rate]}
  end
end
