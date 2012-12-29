require 'spec_helper'

describe User do
  subject{ User.new }

  # Associations
  it should { have_many(:games).dependent(:destroy) }
  it should { have_many :materials, :through => :score }

  # Validations
  it { should validate_presence_of(:name) }

  # Methods
  describe 'current game' do
    before :each do
      @user = FactoryGirl.create(:user)
      red_herring, @game = [Time.now, nil].collect do |time|
        FactoryGirl.create(:game, :user => @user, :completed_at => time)
      end
    end

    describe 'game reset' do
      before(:each){ @user.game_reset! }

      it 'should complete the current game and start a new one' do
        completed_game = @game.reload

        completed_game.completed_at.should_not be_nil
        completed_game.final_score.should_not be_nil
      end
    end

    describe 'current game' do
      it 'should be the last game not completed' do
        @user.current_game.should == @game
      end
    end

    describe 'completed games' do
      describe 'when the user has less than MAX ROUNDS materials' do
        before(:each){ @materials = FactoryGirl.create_list(:material, User::MAX_ROUNDS) }

        it 'should return false' do
          @user.game_completed?.should be_false
        end

        it 'should return true' do
          @user.materials << @materials

          @user.game_completed?.should be_true
        end
      end
    end
  end

  # Behavior
  describe 'email and passwords' do
    before(:each) do
      @attr = {
        :name => "Example User",
        :email => "user@example.com",
        :password => "foobar",
        :password_confirmation => "foobar"
      }
    end

    describe 'email' do
      it "should create a new instance given a valid attribute" do
        User.create!(@attr)
      end

      it "should require an email address" do
        no_email_user = User.new(@attr.merge(:email => ""))
        no_email_user.should_not be_valid
      end

      it "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = User.new(@attr.merge(:email => address))
          valid_email_user.should be_valid
        end
      end

      it "should reject invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = User.new(@attr.merge(:email => address))
          invalid_email_user.should_not be_valid
        end
      end

      it "should reject duplicate email addresses" do
        User.create!(@attr)
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
      end

      it "should reject email addresses identical up to case" do
        upcased_email = @attr[:email].upcase
        User.create!(@attr.merge(:email => upcased_email))
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
      end
    end

    describe "passwords" do
      before(:each) do
        @user = User.new(@attr)
      end

      it "should have a password attribute" do
        @user.should respond_to(:password)
      end

      it "should have a password confirmation attribute" do
        @user.should respond_to(:password_confirmation)
      end
    end

    describe "password validations" do
      it "should require a password" do
        User.new(@attr.merge(:password => "", :password_confirmation => "")).
          should_not be_valid
      end

      it "should require a matching password confirmation" do
        User.new(@attr.merge(:password_confirmation => "invalid")).
          should_not be_valid
      end

      it "should reject short passwords" do
        short = "a" * 5
        hash = @attr.merge(:password => short, :password_confirmation => short)
        User.new(hash).should_not be_valid
      end
    end

    describe "password encryption" do
      before(:each) do
        @user = User.create!(@attr)
      end

      it "should have an encrypted password attribute" do
        @user.should respond_to(:encrypted_password)
      end

      it "should set the encrypted password attribute" do
        @user.encrypted_password.should_not be_blank
      end
    end
  end
end