class Material < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_protected :id

  # Associations
  has_many :users, :through => :score

  # Validations
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :bin, :presence => true, :length => { :maximum => 255 }
  validates :score, :numericality => { :only_integer => true }, :allow_nil => true

  module Bins
    PAPER = 'paper'
    GLASS = 'glass'
    PLASTIC = 'plastic'
    ALUMINUM = 'aluminum'
    COMPOST = 'compost'
    TRASH = 'trash'
    ALL = [PAPER, GLASS, PLASTIC, ALUMINUM, COMPOST, TRASH]
  end
end
