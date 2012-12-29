class Game < ActiveRecord::Base
  attr_accessible :completed_at, :final_score, :user_id

  #Associations
  belongs_to :user, :inverse_of => :games

  # Validations
  validates :user, :presence => true

  # Scopes
  scope :completed, where('completed_at IS NOT NULL')
  scope :current, where(:completed_at => nil)

  def complete!
    self.update_attributes(
      :completed_at => Time.now,
      :final_score => self.user.materials.sum(:score)
    )
    self.user.materials.destroy_all
  end
end
