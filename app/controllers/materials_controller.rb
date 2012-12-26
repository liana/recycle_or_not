class MaterialsController < ApplicationController
  before_filter :find_material, :except => [:index, :new, :create]

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @materials = Material.all
  end

  def show
  end

  def new
    authorize! :new, @user, :message => 'Not authorized as an administrator.'
    @material = Material.new
  end

  def edit
    authorize! :edit, @user, :message => 'Not authorized as an administrator.'
  end

  def create
    authorize! :create, @user, :message => 'Not authorized as an administrator.'
    @material = Material.new(params[:material])

    if @material.save
      redirect_to materials_url, notice: 'Badge was successfully created.'
    else
      flash.now[:error] = @material.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'

    if @material.update_attributes(params[:material], :as => :admin)
      redirect_to materials_url, notice: 'Material was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    @material.destroy
    redirect_to materials_url
  end

  private

  def find_material
    @material = Material.find(params[:id])
  end
end
