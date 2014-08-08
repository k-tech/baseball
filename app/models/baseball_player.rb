# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  player_id  :string(255)
#  birth_year :string(255)
#  name_first :string(255)
#  name_last  :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class BaseballPlayer < ActiveRecord::Base
  has_many :battings
  def self.get_most_improved
    rs = self.where('most_improved IS NOT NULL').order('most_improved desc').limit(200)
    rs.map{|player| player.name_first + " " + player.name_last}
  end
end
