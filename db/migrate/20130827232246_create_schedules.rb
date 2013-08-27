class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.date "date"
      t.string "visitor"
      t.string "home"
      t.string "time"
      t.index :week_id
      t.belongs_to :week
    end
  end
end
