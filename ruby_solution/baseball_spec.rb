require_relative './baseball.rb'

RSpec.describe Batting do
  let(:batting1){ Batting.new(player_id: 'player_id', year_id: '2010', at_bats: 300, hits: 199)}
  let(:batting2){ Batting.new(player_id: 'player_id', year_id: '2009', at_bats: 400, hits: 99)}
  it 'most_improved get correct result' do
    expect(Batting).to receive(:list) { [batting1, batting2] }
    expect(Batting.most_improved).to eq 'player_id'
  end

  let(:batting4){ Batting.new(player_id: 'player_id1', year_id: '2012', league: 'NL', at_bats: 500, hits: 199, doubles: 130, triples: 36, home_runs: 200, runs_batted_in: 10)}
  it 'triple_crown_winner get correct result' do
    expect(Batting).to receive(:list).at_least(5) { [batting4] }
    expect(Batting.triple_crown_winner('2012', 'NL')).to eq [batting4]
  end

  it 'triple_crown_winner will return empty' do
    expect(Batting).to receive(:list).at_least(2) { [batting2] }
    expect(Batting.triple_crown_winner('2012', 'NL')).to eq []
  end

  let(:batting5){ Batting.new(player_id: 'player_id', year_id: '2010', at_bats: 300, hits: 199)}
  let(:batting6){ Batting.new(player_id: 'player_id', year_id: '2009', at_bats: 100, hits: 99)}
  it 'most_improved return empty when at_bats < 200' do
    expect(Batting).to receive(:list) { [batting5, batting6] }
    expect(Batting.most_improved).to eq ''
  end

  let(:batting7){ Batting.new(player_id: 'player_id', year_id: '2011', at_bats: 300, hits: 199)}
  let(:batting8){ Batting.new(player_id: 'player_id', year_id: '2009', at_bats: 200, hits: 99)}
  it 'most_improved return empty when year not equal to 2009 or 2010' do
    expect(Batting).to receive(:list) { [batting5, batting6] }
    expect(Batting.most_improved).to eq ''
  end
end

RSpec.describe Baseball do
  let(:batting3){ Batting.new(player_id: 'player_id', team_id: 'OAK',  year_id: '2007', at_bats: 300, hits: 199, doubles: 130, triples: 36, home_runs: 200)}
  before do 
    expect(Player).to receive(:import_csv)
    expect(Batting).to receive(:import_csv)
  end

  it 'slugging' do
    expect(Batting).to receive(:list) { [batting3] }
    expect(Baseball.new.get_slugging.first).to be_within(0.5).of(3.3)
  end

  let(:batting4){ Batting.new(player_id: 'player_id1', year_id: '2007', league: 'NL', at_bats: 300, hits: 199, doubles: 130, triples: 36, home_runs: 200, runs_batted_in: 10)}
  it 'triple_crown_winner return correct winner name' do
    expect(Batting).to receive(:triple_crown_winner){[batting4]}
    expect(Player).to receive(:player_id_2_fullname).with('player_id1') { 'Joe Brown'}
    expect(Baseball.new.triple_crown_winner).to eq 'Joe Brown'
  end

  it 'triple_crown_winner return no winner' do
    expect(Batting).to receive(:triple_crown_winner){[]}
    expect(Baseball.new.triple_crown_winner).to eq 'No Winner'
  end
end

RSpec.describe Player do

  let(:player1){Player.new(player_id: 'player_id', name_first: 'Joe', name_last: 'Brown')}

  it 'should able to return fullname' do
    expect(Player).to receive(:list){[player1]}
    expect(Player.player_id_2_fullname('player_id')).to eq 'Joe Brown'
  end

end