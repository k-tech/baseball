class ImportService
  def self.import_to_db
    start_time = Time.now
    ActiveRecord::Base.connection.execute("DELETE FROM players")
    p 'finished drop players'
    players = File.readlines('db/Master-small.csv')[0].gsub("\n", '').split("\r")
    players.drop(1).each do |row|
      data = row.split(',')
      Player.create(
        player_id: data[0],
        birth_year: data[1],
        name_first: data[2],
        name_last: data[3]
      )
      print '.'
    end
    puts "Player table time cost: #{Time.now - start_time}"
    start_time = Time.now
    ActiveRecord::Base.connection.execute("DELETE FROM battings")
    p 'finished drop battings'
    lines = File.readlines('db/Batting-07-12.csv')[0].gsub("\n", '').split("\r")
    lines.drop(1).each do |row|
      print '.'
      data = row.split(',')
      Batting.create(
        player_id: data[0],
        year_id: data[1],
        league: data[2],
        team_id: data[3],
        games_played: data[4].to_i,
        at_bats: data[5].to_i,
        runs: data[6].to_i,
        hits: data[7].to_i,
        doubles: data[8].to_i,
        triples: data[9].to_i,
        home_runs: data[10].to_i,
        runs_batted_in: data[11].to_i,
        stolen_bases: data[12].to_i,
        caught_stealing: data[13].to_i,
        created_at: data[14],
        updated_at: data[15]
      )
    end
    puts "Batting table time cost: #{Time.now - start_time}"
  end
end
