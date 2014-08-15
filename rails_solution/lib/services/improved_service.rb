class ImprovedService
  class << self
    attr_accessor :players
    def most_improved from=2009, to=2010, at_bats=200
      generate_bat_ave
      calculate_most_improved from, to, at_bats
      output_players
    end

    def most_improved2 from=2009, to=2010, at_bats=200
      generate_bat_ave
      calculate_most_improved2 from, to, at_bats
      output_players
    end

    private

    def generate_bat_ave
      Batting.where(bat_ave: nil).where("at_bats <> 0").find_each do |b|
        b.update(bat_ave: b.hits.to_f / b.at_bats)
      end
    end

    def calculate_most_improved from, to, at_bats
      players = {}
      Batting.batting_ave_condition(at_bats).in_years(from, to).find_each do |row|
        players[row.player_id] ||= {}
        players[row.player_id].merge!( row.year_id => row.bat_ave )
      end

      players.each do |key, value|
        players[key].merge!(rate: value["#{to}"] - value["#{from}"]) if value["#{to}"] && value["#{from}"]
      end
      players = players.delete_if{|key, value| value["#{to}"].blank? || value["#{from}"].blank?}
      @players = players.sort_by{|k, v| v[:rate]}.reverse.map{|k, v| [k, v[:rate]]}
    end

    def calculate_most_improved2 from, to, at_bats
      result = {}
      lefts = Batting.where(year_id: to).where('bat_ave is not null and at_bats >= ?', at_bats)
      lefts.each do |left|
        right = Batting.where(year_id: from, player_id: left.player_id).where('bat_ave is not null and at_bats >= ?', at_bats).first
        result[left.player_id] = left.bat_ave - right.bat_ave if right
      end
      @players = result.sort_by{|k, v| v}.reverse
    end

    def output_players
      @players.map do |v| 
        [Player.find_by(player_id: v[0]).full_name, v[1]]
      end
    end
  end
end
