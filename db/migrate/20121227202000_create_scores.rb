class CreateScores < ActiveRecord::Migration
  def up
    create_table :scores do |t|
      t.integer :user_id
      t.integer :material_id

      t.timestamps
    end

    add_index :scores, :user_id
    add_index :scores, :material_id
  end

  def down
    drop_table :scores
  end
end
