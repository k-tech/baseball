desc "import csv data to database"
task import: :environment do
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
      games_played: data[4],
      at_bats: data[5],
      runs: data[6],
      hits: data[7],
      doubles: data[8],
      triples: data[9],
      home_runs: data[10],
      runs_batted_in: data[11],
      stolen_bases: data[12],
      caught_stealing: data[13],
      created_at: data[14],
      updated_at: data[15]
    )
  end
  puts "Batting table time cost: #{Time.now - start_time}"
end
