class AddDescriptionToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :description, :string
  end
end
