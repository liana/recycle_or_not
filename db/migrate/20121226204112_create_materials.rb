class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.string :image
      t.string :bin
      t.integer :score

      t.timestamps
    end
  end
end
