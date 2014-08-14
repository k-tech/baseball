class SluggingPercentageService
  def self.get_slugging team='OAK', year=2007
    rs = Batting.where(team_id: team, year_id: year)
    rs.map{|b| slugging = ((b.hits.to_f - b.doubles.to_f - b.triples.to_f - b.home_runs.to_f) + (2 * b.doubles.to_f) + (3 * b.triples.to_f) + (4 * b.home_runs.to_f)) / b.at_bats.to_f if b.at_bats != 0; slugging}.compact
  end
end
