class CreateUsersWeeks < ActiveRecord::Migration
  def change
    create_join_table :users, :weeks do |t|
      t.index :user_id
      t.index :week_id
      t.index :pool_id
      t.belongs_to :user
      t.belongs_to :week
      t.belongs_to :pool
      t.integer "total_games"
      t.integer "total_wins"
      t.integer "total_losses"
      t.integer "win_percentage"
      t.boolean "complete"
      t.timestamps
    end
  end
end
