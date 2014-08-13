class ImprovedService
  def self.most_improved
    rs = Batting.where("at_bats >= 200").all
    player = {}
    rs.each do |row|
      unless (row.hits == 0) or (row.at_bats == 0)
        player[row.player_id] = {} unless player[row.player_id].present? 
        player[row.player_id].merge!( row.year_id => row.hits.to_f / row.at_bats.to_f)
      end
    end

    player.each do |key, value|
      player[key].merge!(rate: value['2010'] - value['2009']) if value['2010'].present? and value['2009'].present?
    end
    player = player.delete_if{|key, value| value['2010'].blank? or value['2009'].blank?}
    player = player.sort_by{|k, v| v[:rate]}.reverse
    player.map do |key, value| 
      Player.find_by_player_id(key).full_name
    end
  end
end
