class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :final_score
      t.datetime :completed_at

      t.timestamps
    end
  end
end
