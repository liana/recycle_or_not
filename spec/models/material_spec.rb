require 'spec_helper'

describe Material do
  subject{ Material.new }

  # Associations
  it should { have_many :users, :through => :score }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:bin) }
  it { should validate_numericality_of(:score) }

  # Methods
  describe 'next_for' do
    before do
      @user = FactoryGirl.create(:user)
      @materials = FactoryGirl.create_list(:material, 5)
      @user.materials << @materials.pop
    end

    it 'should return a material' do
      @materials.should include(Material.next_for(@user))
    end

    it 'should not already belong to a user' do
      @materials.take_while do
        @user.materials.should_not include(Material.next_for(@user))
        @user.materials << @materials.pop
      end
    end
  end
end
