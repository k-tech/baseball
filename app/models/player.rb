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

class Player < ActiveRecord::Base
end
