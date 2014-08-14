require 'byebug'
class Baseball
  def initialize player_file='./files/Master-small.csv', batting_file='./files/Batting-07-12.csv'
    Player.import_csv player_file
    Batting.import_csv batting_file
  end

  def run
    p most_improved
    p get_slugging
    p triple_crown_winner
  end

  def most_improved
    player_id = Batting.most_improved
    Player.list.select{|player| player.player_id == player_id}.first.fullname
  end

  def get_slugging
    rs = {}
    Batting.get_slugging.each{|k, v| rs.merge!({Player.player_id_2_fullname(k) => v})}
    rs
  end

  def triple_crown_winner(year='2012', league='NL')
    winners = Batting.triple_crown_winner(year, league)
    winners.empty? ? 'No Winner' : winners.map{|batting| Player.player_id_2_fullname(batting.player_id)}.join(', ')
  end

end

class Player

  attr_accessor :player_id, :birth_year, :name_first, :name_last

  def initialize(params={})
    params.each {|k, v| self.send("#{k}=", v)}
  end

  def fullname
    self.name_first + ' ' + self.name_last
  end

  class << self
    attr_accessor :list

    def player_id_2_fullname(player_id)
      list.select{|player| player.player_id == player_id}.first.fullname
    end

    def import_csv( file = './files/Master-small.csv' )
      players = File.readlines(file)[0].gsub("\n", '').split("\r")
      Player.list = []
      players.drop(1).each do |row|
        data = row.split(',')
        Player.list << Player.new(player_id: data[0], birth_year: data[1], name_first: data[2], name_last: data[3])
      end
    end
  end

end

class Batting
  attr_accessor :player_id, :year_id, :league, :team_id, :games_played, :at_bats, :runs, :hits, :doubles, :triples, :home_runs, :runs_batted_in, :stolen_bases, :caught_stealing, :bat_ave

  def initialize(params={})
    params.each{|k, v| self.send("#{k}=", v)}
    self.bat_ave = self.hits / self.at_bats if self.at_bats and self.hits and self.at_bats != 0
  end

  class << self
    attr_accessor :list

    def import_csv( file = './files/Batting-07-12.csv')
      battings = File.readlines(file)[0].gsub("\n", '').split("\r")
      Batting.list = []
      battings.drop(1).each do |row|
        data = row.split(',')
        Batting.list << Batting.new(
          {
            player_id: data[0],
            year_id: data[1],
            league: data[2],
            team_id: data[3],
            games_played: data[4].to_f,
            at_bats: data[5].to_i,
            runs: data[6].to_i,
            hits: data[7].to_i,
            doubles: data[8].to_i,
            triples: data[9].to_i,
            home_runs: data[10].to_i,
            runs_batted_in: data[11].to_i,
            stolen_bases: data[12].to_i,
            caught_stealing: data[13].to_i
          })
      end
    end

    def ready_for_triple(year, league, spec)
      get_available_for_slugging.select{|batting|batting.year_id == year and  batting.league == league and batting.at_bats > 400 }
    end

    def get_available_for_slugging
      list.select{|batting| batting.hits and batting.doubles and batting.triples and batting.home_runs and batting.at_bats}
    end

    def year_league_winners(year, league, spec)
      ready_for_triple(year, league, spec).select{|batting| batting.send(spec.to_sym) == self.best_score(year, league, spec)}
    end

    def best_score(year='2011', league='NL', spec='home_runs')
      ready_for_triple(year, league, spec).max_by{|batting|batting.send(spec.to_sym)}.send(spec.to_sym)
    end

    def triple_crown_winner(year, league)
      %w(runs_batted_in bat_ave).inject(year_league_winners(year, league, 'home_runs')) do |rs, spec|
        rs &= year_league_winners(year, league, spec)
      end
    end

    def most_improved
      rs = list.select{ |batting| batting.at_bats && batting.at_bats.to_i >= 200}
      player = {}
      rs.each do |row|
        unless (row.hits == 0) or (row.at_bats == 0)
          player[row.player_id] = {} unless player[row.player_id] 
          player[row.player_id].merge!( row.year_id => row.hits.to_f / row.at_bats.to_f)
        end
      end

      player.each do |key, value|
        player[key].merge!(rate: value['2010'] - value['2009']) if value['2010'] and value['2009']
      end
      player = player.delete_if{|key, value| value['2010'].nil? or value['2009'].nil?}
      rs = player.sort_by{|k, v| v[:rate]}.last
      rs.nil?? '' : rs.first
    end

    def get_slugging
      output = {}
      rs = get_available_for_slugging.select{|batting| batting.team_id == 'OAK' and batting.year_id == '2007'}
      rs.each{|b| slugging = ((b.hits.to_f - b.doubles.to_f - b.triples.to_f - b.home_runs.to_f) + (2 * b.doubles.to_f) + (3 * b.triples.to_f) + (4 * b.home_runs.to_f)) / b.at_bats.to_f if b.at_bats != 0; output.merge!({b.player_id => slugging})}
      output.delete_if{|k, v| v.nil?}
    end
  end

end

baseball = if ARGV.size >= 2
  Baseball.new(ARGV[0], ARGV[1])
else
  Baseball.new
end

#baseball.run
