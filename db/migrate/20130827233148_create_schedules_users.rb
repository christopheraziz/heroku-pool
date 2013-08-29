class CreateSchedulesUsers < ActiveRecord::Migration
  def change
    create_join_table :schedules, :users do |t|
      t.index :schedule_id
      t.index :user_id
      t.belongs_to :user
      t.belongs_to :schedule
      t.belongs_to :pool
      t.belongs_to :week, :null => true
      t.string "pick"
      t.string "winner", :null => true
      t.timestamps
    end
  end
end
