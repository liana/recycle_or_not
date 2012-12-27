class Game < ActiveRecord::Base
  attr_accessible :completed_at, :final_score, :user_id

  #Associations
  belongs_to :user, :inverse_of => :games

  # Validations
  validates :user, :presence => true

  # Scopes
  scope :completed, where('completed_at IS NOT NULL')
end
