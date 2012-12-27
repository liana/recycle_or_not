require 'spec_helper'

describe HomeController do
  describe 'a GET to #index' do
    it 'should return :success' do
      get :index

      should respond_with(:success)
    end
  end
end
