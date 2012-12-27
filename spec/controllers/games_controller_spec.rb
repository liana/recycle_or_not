require 'spec_helper'

describe GamesController do
  before :each do
    @admin = FactoryGirl.create(:admin)
    sign_in @admin
  end

  describe 'a GET to #index' do
    it 'should return :success' do
      get :index

      should respond_with(:success)
    end
  end
end