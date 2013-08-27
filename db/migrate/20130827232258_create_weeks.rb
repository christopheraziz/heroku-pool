class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.date "week_start"
      t.date "week_end"
      t.boolean "played", :default => false
      t.timestamps
    end
  end
end
