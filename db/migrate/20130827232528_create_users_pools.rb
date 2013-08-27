class CreateUsersPools < ActiveRecord::Migration
  def change
    create_join_table :users, :pools, table_name: :users_pools do |t|
      t.index :user_id
      t.index :pool_id
      t.belongs_to :user
      t.belongs_to :pool
      t.string "pool_name"
      t.timestamps
    end
  end
end