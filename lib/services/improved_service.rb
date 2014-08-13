class ImprovedService
  def self.most_improved from_year=2009, to_year=2010, at_bats=200
    rs = Batting.where("at_bats >= ?", at_bats).all
    player = {}
    rs.each do |row|
      unless (row.hits == 0) or (row.at_bats == 0)
        player[row.player_id] = {} unless player[row.player_id].present? 
        player[row.player_id].merge!( row.year_id => row.hits.to_f / row.at_bats.to_f)
      end
    end

    player.each do |key, value|
      player[key].merge!(rate: value["#{to_year}"] - value["#{from_year}"]) if value["#{to_year}"] && value["#{from_year}"]
    end
    player = player.delete_if{|key, value| value["#{to_year}"].blank? || value["#{from_year}"].blank?}
    player = player.sort_by{|k, v| v[:rate]}.reverse
    player.map do |key, value| 
      Player.find_by_player_id(key).full_name
    end
  end

  def self.most_improved2 from_year=2009, to_year=2010, at_bats=200
    result = {}
    lefts = Batting.where(year_id: to_year).where('bat_ave is not null and at_bats >= ?', at_bats)
    lefts.each do |left|
      right = Batting.where(year_id: from_year, player_id: left.player_id).where('bat_ave is not null and at_bats >= ?', at_bats).first
      result[left.player_id] = left.bat_ave - right.bat_ave if right
    end
    result = result.sort_by{|k, v| v}
  end
end
