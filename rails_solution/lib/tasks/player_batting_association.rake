desc "calculate substraction of batting average 2010 and 2009 "
task bat_ave_substraction: :environment do
  Player.find_each do |player|
    @rs = player.battings.gt_bats(200)
    next unless @rs
    first = @rs.find_by(year_id: '2009').try('bat_ave')
    second = @rs.find_by(year_id: '2010').try('bat_ave')
    player.update(most_improved: second - first) if first && second
    print '.'
  end
end
