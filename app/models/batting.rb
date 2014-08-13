require 'services/improved_service'
require 'services/slugging_percentage_service'
require 'services/triple_crown_winner_service'

class Batting < ActiveRecord::Base
  belongs_to :player, primary_key: :player_id, foreign_key: :player_id

  before_create :generate_bat_ave
  default_scope -> {where("hits is not null and runs is not null and doubles is not null and triples is not null and home_runs is not null and at_bats is not null")}
  scope :batting_ave_condition, -> {where("at_bats >= 200")}

  delegate :full_name, to: :player, prefix: true

  def self.get_slugging 
    SluggingPercentageService.get_slugging
  end

  def self.triple_crown_winner(year, league)
    TripleCrownWinnerService.triple_crown_winner(year, league)
  end
  
  def self.most_improved2
    result = {}
    lefts = Batting.where(year_id: '2010').where('bat_ave is not null and at_bats >= 200')
    lefts.each do |left|
      right = Batting.where(year_id: '2009', player_id: left.player_id).where('bat_ave is not null and at_bats >= 200').first
      result[left.player_id] = left.bat_ave - right.bat_ave if right
    end
    result = result.sort_by{|k, v| v}
  end

  def self.most_improved
    ImprovedService.most_improved
  end

  private
  def generate_bat_ave
    self.bat_ave = self.hits.to_f / self.at_bats unless self.at_bats.zero?
  end
end
