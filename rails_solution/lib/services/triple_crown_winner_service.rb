class TripleCrownWinnerService
  def self.triple_crown_winner(year, league)
    winners = %w(runs_batted_in bat_ave).inject(Batting.year_league_winners(year, league, 'home_runs')) do |rs, spec|
      rs &= Batting.year_league_winners(year, league, spec)
    end
    winners.empty? ? 'No Winner' : winners.map(&:player_full_name).join(', ')
  end
end
