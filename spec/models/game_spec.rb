require 'spec_helper'

describe Game do
  subject{ Game.new }

  # Associations
  it should { belong_to :user }

  # Validations
  it { should validate_presence_of(:user) }

  # Methods
  describe 'complete' do
    before :each do
      @user = FactoryGirl.create(:user)
      @game = FactoryGirl.build(:game, :user => @user)
      @materials = @user.materials << FactoryGirl.build_list(:material, 2, :score => 10)

      @game.complete!
    end

    it 'should complete the user game' do
      @game.completed_at.should be_present
      @game.final_score.should == 20
      @user.materials.should be_empty
    end
  end
end
