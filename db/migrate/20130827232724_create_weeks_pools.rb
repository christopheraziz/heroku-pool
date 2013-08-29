class CreateWeeksPools < ActiveRecord::Migration
  def change
    create_join_table :weeks, :pools, table_name: :weeks_pools do |t|
      t.index :week_id
      t.index :pool_id
      t.belongs_to :week
      t.belongs_to :pool
      t.belongs_to :user
      t.string "week_winner"
      t.boolean "complete"
      t.timestamps
    end
  end
end
