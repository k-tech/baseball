class Batting < ActiveRecord::Base
  belongs_to :player, primary_key: :player_id, foreign_key: :player_id

  validates :player_id, :year_id, :league, :team_id, presence: true
  validates_uniqueness_of :player_id, scope: :year_id

  before_create :generate_bat_ave

  scope :batting_ave_condition, ->(at_bats) { where("at_bats >= 200").where("hits <> 0") }
  scope :in_years, ->(*years) { where(year_id: years) }
  scope :in_team, ->(team) { where(team_id: team) }

  delegate :full_name, to: :player, prefix: true

  def slugging_percentage
    ((hits.to_f - doubles.to_f - triples.to_f - home_runs.to_f) + (2 * doubles.to_f) + (3 * triples.to_f) + (4 * home_runs.to_f)) / at_bats.to_f if at_bats != 0
  end

  private
  def generate_bat_ave
    self.bat_ave = self.hits.to_f / self.at_bats unless self.at_bats.zero?
  end
end
