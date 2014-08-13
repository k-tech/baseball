require 'test_helper'
require 'services/improved_service'
require 'services/slugging_percentage_service'
require 'services/triple_crown_winner_service'

describe Batting do
  test "most improved" do
    assert_equal [players(:one).full_name, players(:two).full_name], ImprovedService.most_improved
  end

  test "most improved with from_year and to_year" do
    battings(:batting_2).update year_id: 2011
    battings(:batting_4).update year_id: 2011
    assert_equal [players(:one).full_name, players(:two).full_name], ImprovedService.most_improved(2009, 2011)
  end

  test "most improved2" do
    expected = [
      [players(:two).player_id, battings(:batting_4).bat_ave-battings(:batting_3).bat_ave], 
      [players(:one).player_id, battings(:batting_2).bat_ave-battings(:batting_1).bat_ave], 
    ]
    assert_equal expected, ImprovedService.most_improved2
  end

  test "most improved2 with from_year and to_year" do
    battings(:batting_1).update year_id: 2007
    battings(:batting_3).update year_id: 2007
    expected = [
      [players(:two).player_id, battings(:batting_4).bat_ave-battings(:batting_3).bat_ave], 
      [players(:one).player_id, battings(:batting_2).bat_ave-battings(:batting_1).bat_ave], 
    ]
    assert_equal expected, ImprovedService.most_improved2(2007, 2010)
  end

  test "should calculate bat_ave" do
    battings(:batting_1).send(:generate_bat_ave)
    assert_equal(10.0/255, battings(:batting_1).bat_ave)
  end

  test "slugging percentage" do
    b = battings(:batting_5)
    slugging_percentage = ((b.hits-b.doubles-b.triples-b.home_runs)+2*b.doubles+3*b.triples+4*b.home_runs)*1.0/b.at_bats
    assert_equal([slugging_percentage], SluggingPercentageService.get_slugging)
  end

  test "slugging percentage with team and year" do
    b = battings(:batting_5)
    b.update team_id: 'HOU'
    slugging_percentage = ((b.hits-b.doubles-b.triples-b.home_runs)+2*b.doubles+3*b.triples+4*b.home_runs)*1.0/b.at_bats
    assert_equal [slugging_percentage], SluggingPercentageService.get_slugging('HOU', 2007)
  end

  test "triple crown winner" do
    assert_equal players(:one).full_name, TripleCrownWinnerService.triple_crown_winner(2011, 'NL')
    assert_equal "No Winner", TripleCrownWinnerService.triple_crown_winner(2012, 'NL')
  end

end
