class TripleCrownWinnerService
  class << self
    def triple_crown_winner(year, league)
      winners = %w(runs_batted_in bat_ave).inject(year_league_winners(year, league, 'home_runs')) do |rs, spec|
        rs &= year_league_winners(year, league, spec)
      end
      winners.empty? ? 'No Winner' : winners.map(&:player_full_name).join(', ')
    end

    private
    def year_league_winners year, league, spec
      Batting.where(year_id: year, league: league).where('at_bats >= 400').where(spec => best_score(year, league, spec))
    end

    def best_score(year, league, spec)
      Batting.where(year_id: year, league: league).where('at_bats > 400').maximum(spec)
    end
  end
end
