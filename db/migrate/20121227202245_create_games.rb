class CreateGames < ActiveRecord::Migration
  def up
    create_table :games do |t|
      t.integer :user_id
      t.integer :final_score
      t.datetime :completed_at

      t.timestamps
    end

    add_index :games, :user_id
  end

  def down
    drop_table :games
  end
end
