desc "calculate batting average"
task batting_average: :environment do
  Batting.find_each do |bat|
    if bat.hits && bat.at_bats && !bat.at_bats.zero?
      print '.'
      bat.update(bat_ave: bat.hits / bat.at_bats.to_f)
    end
  end
end

desc "calculate substraction of batting average 2010 and 2009 "
task bat_ave_substraction: :environment do
  Player.find_each do |player|
    @rs = player.battings.where("at_bats >= 200")
    next unless @rs
    first = @rs.find_by(year_id: '2009').try('bat_ave')
    second = @rs.find_by(year_id: '2010').try('bat_ave')
    player.update(most_improved: second - first) if first && second
    print '.'
  end
end
