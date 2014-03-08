class MaterialsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :show
  before_filter :add_to_score, :only => :show

  def index
    @materials = Material.all
  end

  def show
    @path = if current_user.game_completed?
      current_user.game_reset!
      root_path
    else
      @next_material = Material.next_for(current_user)
      material_path(@next_material, :last_id => @material.id)
    end
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

  private

  def add_to_score
    if params[:last_id].present?
      current_user.materials << Material.find(params[:last_id])
    end
  end
end
