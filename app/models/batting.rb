require 'services/improved_service'
require 'services/slugging_percentage_service'
require 'services/triple_crown_winner_service'

class Batting < ActiveRecord::Base
  belongs_to :player, primary_key: :player_id, foreign_key: :player_id

  before_create :generate_bat_ave
  default_scope -> {where("hits is not null and runs is not null and doubles is not null and triples is not null and home_runs is not null and at_bats is not null")}
  scope :batting_ave_condition, -> {where("at_bats >= 200")}

  delegate :full_name, to: :player, prefix: true

  private
  def generate_bat_ave
    self.bat_ave = self.hits.to_f / self.at_bats unless self.at_bats.zero?
  end
end
