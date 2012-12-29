class Material < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_protected :id

  # Associations
  has_and_belongs_to_many :users
  has_many :scores
  has_many :users, :through => :scores

  # Validations
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :bin, :presence => true, :length => { :maximum => 255 }
  validates :score, :numericality => { :only_integer => true }, :allow_nil => true

  module Bins
    PAPER = 'paper'
    GLASS = 'glass'
    PLASTIC = 'plastic'
    CAN = 'can'
    COMPOST = 'compost'
    TRASH = 'trash'
    ALL = [CAN, COMPOST, GLASS, PAPER, PLASTIC, TRASH]
  end

  # Methods
  def self.next_for(user)
    materials = user.materials.empty? ? 0 : user.materials

    where('id NOT IN (?)', materials).order("RANDOM()").first
  end
end
