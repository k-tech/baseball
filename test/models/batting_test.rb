require 'test_helper'

describe Batting do
  test "most improved" do
    assert_equal [players(:one).full_name, players(:two).full_name], Batting.most_improved
  end

  test "most improved2" do
    assert_equal [players(:one).full_name, players(:two).full_name], Batting.most_improved2
  end

  test "should calculate bat_ave" do
    battings(:batting_1).send(:generate_bat_ave)
    assert_equal(10.0/255, battings(:batting_1).bat_ave)
  end

  test "slugging percentage" do
    b = battings(:batting_5)
    slugging_percentage = ((b.hits-b.doubles-b.triples-b.home_runs)+2*b.doubles+3*b.triples+4*b.home_runs)*1.0/b.at_bats
    assert_equal([slugging_percentage], Batting.get_slugging)
  end

  test "triple crown winner" do
    assert_equal(players(:one).full_name, Batting.triple_crown_winner(2011, 'NL'))
    assert_equal("No Winner", Batting.triple_crown_winner(2012, 'NL'))
  end

end
