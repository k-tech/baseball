class SluggingPercentageService
  class << self
    def get_slugging team='OAK', year=2007
      rs = Batting.in_team(team).in_years(year).map(&:slugging_percentage).compact
    end
  end
end
