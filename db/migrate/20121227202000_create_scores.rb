class CreateScores < ActiveRecord::Migration
  def up
    create_table :score do |t|
      t.integer :user_id
      t.integer :material_id

      t.timestamps
    end
  end

  def down
    #drop_table :scores
  end
end
