require 'spec_helper'

describe Game do
  subject{ Game.new }

  # Associations
  it should { belong_to :user }

  # Validations
  it { should validate_presence_of(:user) }
end
