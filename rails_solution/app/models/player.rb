class Player < ActiveRecord::Base
  has_many :battings, primary_key: :player_id, foreign_key: :player_id

  validates :player_id, :name_first, :name_last, presence: true

  def self.get_most_improved
    rs = self.where('most_improved IS NOT NULL').order('most_improved desc').limit(200)
    rs.map{|player| player.name_first + " " + player.name_last}
  end


  def full_name
    name_first + ' ' + name_last
  end
end
