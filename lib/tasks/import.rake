desc "import csv line to linebase"
task import: :environment do
  def measure_time
    start_time = Time.now
    yield
    Time.now - start_time
  end

  require 'csv'
  connection =  Mysql2::Client.new(ActiveRecord::Base.configurations[Rails.env])

  cost = measure_time do
    ActiveRecord::Base.connection.execute("DELETE FROM players")
    p 'finished drop players'
    Upsert.batch(connection, :players) do |upsert|
      players = File.readlines('db/Master-small.csv')[0].gsub("\n", '').split("\r")
      players.drop(1).each do |row|
        line = row.split(",")
        upsert.row({
          player_id: line[0], 
          birth_year: line[1], 
          name_first: line[2], 
          name_last: line[3],
          created_at: Time.now,
          updated_at: Time.now
        })
      end
    end
  end
  puts "Player table time cost: #{cost}s"

  cost = measure_time do
    ActiveRecord::Base.connection.execute("DELETE FROM battings")
    p 'finished drop battings'
    Upsert.batch(connection, :battings) do |upsert|
      battings = File.readlines('db/Batting-07-12.csv')[0].gsub("\n", '').split("\r")
      battings.drop(1).each do |row|
        line = row.split(",")
        upsert.row({
          player_id: line[0],
          year_id: line[1],
          league: line[2],
          team_id: line[3],
          games_played: line[4],
          at_bats: line[5],
          runs: line[6],
          hits: line[7],
          doubles: line[8],
          triples: line[9],
          home_runs: line[10],
          runs_batted_in: line[11],
          stolen_bases: line[12],
          caught_stealing: line[13],
          created_at: Time.now,
          updated_at: Time.now
        })
      end
    end
  end
  puts "Batting table time cost: #{cost}s"

  p "Import #{Player.count} Player and #{Batting.count} Batting"
end
