class MaterialsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  def index
    @materials = Material.all
  end

  def show
  end

  def new
    @material = Material.new
  end

  def edit
  end

  def create
    @material = Material.new(params[:material])

    if @material.save
      redirect_to materials_url, :notice => 'Material was successfully created.'
    else
      flash.now[:error] = @material.errors.full_messages.join(', ')
      render :new
    end
  end

  def update
    if @material.update_attributes(params[:material], :as => :admin)
      redirect_to materials_url, :notice => 'Material was successfully updated.'
    else
      render :action => :edit
    end
  end

  def destroy
    @material.destroy
    redirect_to materials_url
  end
end
