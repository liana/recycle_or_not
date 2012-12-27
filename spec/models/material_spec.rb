require 'spec_helper'

describe Material do
  subject{ Material.new }

  # Associations
  it should { have_many :users, :through => :score }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:bin) }
  it { should validate_numericality_of(:score) }
end
