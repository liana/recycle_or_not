class Material < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  attr_protected :id

  # Validations
  validates :name, :presence => true, :length => { :maximum => 255 }
  validates :bin, :presence => true, :length => { :maximum => 255 }
  validates :score, :numericality => { :only_integer => true }, :allow_nil => true
end
