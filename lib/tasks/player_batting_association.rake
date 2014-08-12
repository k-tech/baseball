desc "associate player_id between players and battings"
task associate_player_and_batting: :environment do
  Batting.all.each do |batting|
    player = BaseballPlayer.find_by_player_id(batting.player_id)
    batting.update_attributes(baseball_player: player)
    print '.' 
  end
end

desc "calculate batting average"
task batting_average: :environment do
  Batting.all.each do |bat|
    if bat.hits and bat.at_bats and bat.at_bats != 0
      print '.'
      bat.update_attributes(bat_ave: bat.hits / bat.at_bats.to_f)
    end
  end
end

desc "calculate substraction of batting average 2010 and 2009 "
task bat_ave_substraction: :environment do
  BaseballPlayer.all.each do |player|
    @rs = player.battings.where("at_bats >= 200")
    first = @rs.find_by_year_id('2009').try('bat_ave') if @rs
    second = @rs.find_by_year_id('2010').try('bat_ave') if @rs
    player.update_attributes(most_improved: second - first) if first and second
    print '.'
  end
end
