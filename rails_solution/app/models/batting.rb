class Batting < ActiveRecord::Base
  belongs_to :player, primary_key: :player_id, foreign_key: :player_id

  validates :player_id, :year_id, :league, :team_id, presence: true

  before_create :generate_bat_ave
  scope :batting_ave_condition, -> {where("at_bats >= 200")}
  delegate :full_name, to: :player, prefix: true

  private
  def generate_bat_ave
    self.bat_ave = self.hits.to_f / self.at_bats unless self.at_bats.zero?
  end
end
