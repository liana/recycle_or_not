require 'spec_helper'

describe MaterialsController do
  before :each do
    @material = FactoryGirl.create(:material)
    @attr = FactoryGirl.attributes_for(:material)
    @user = FactoryGirl.create(:admin)
    sign_in @user
  end

  describe 'a GET to #index' do
    it 'should return :success' do
      get :index

      should respond_with(:success)
    end
  end

  describe 'a GET to #new' do
    it 'should return :success' do
      get :new

      should respond_with(:success)
    end
  end

  describe 'a GET to #edit' do
    before :each do
      Material.stub(:find).and_return(@material)
      Material.should_receive(:find)
    end

    it 'should return :success' do
      get :edit, :id => @material

      should respond_with(:success)
    end
  end


  describe "POST create" do
    describe 'a POST to #create with valid attributes' do
      before :each do
        @material = Material.new
        Material.stub(:new).and_return @material
        @material.stub(:save).and_return true
        @material.should_receive(:save)
      end

      it 'should redirect to the material index' do
        post :create, :material => FactoryGirl.attributes_for(:material)

        should redirect_to(materials_url)
      end
    end

    describe 'a POST to #create with invalid attributes' do
      before :each do
        @material = Material.new
        Material.stub(:new).and_return @material
        @material.stub(:save).and_return false
        @material.should_receive(:save)
      end

      it 'should render :new' do
        post :create, :material => {}

        should render_template(:new)
        should respond_with(:success)
      end
    end
  end

  describe "PUT update" do
    describe 'a POST to #update with valid attributes' do
      before :each do
        @material = FactoryGirl.create(:material)
        Material.stub(:find).and_return @material
        @material.stub(:update_attributes).and_return true
        @material.should_receive(:update_attributes)
      end

      it 'should redirect to the material index' do
        post :update, :id => @material, :material => FactoryGirl.attributes_for(:material)

        should redirect_to(materials_url)
      end
    end

    describe 'a POST to #update with invalid attributes' do
      before :each do
        @material = FactoryGirl.create(:material)
        Material.stub(:find).and_return @material
        @material.stub(:update_attributes).and_return false
        @material.should_receive(:update_attributes)
      end

      it 'should render :edit' do
        post :update, :id => @material, :material => {}

        should render_template(:edit)
        should respond_with(:success)
      end
    end
  end

  describe 'a PUT to #destroy' do
    before :each do
      Material.stub(:find).and_return(@material)
      @material.should_receive(:destroy)
    end

    it 'should return :success' do
      delete :destroy, :id => @material

      should redirect_to(materials_url)
    end
  end
end