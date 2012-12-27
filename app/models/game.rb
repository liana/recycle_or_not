class Game < ActiveRecord::Base
  attr_accessible :completed_at, :final_score, :user_id
end
