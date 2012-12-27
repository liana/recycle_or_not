class Score < ActiveRecord::Base

  #Associations
  belongs_to :user, :inverse_of => :scores
  belongs_to :material, :inverse_of => :scores

  # Validations
  validates :user, :presence => true
  validates :material, :presence => true
end
