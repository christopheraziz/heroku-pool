class WeeksPool < ActiveRecord::Base
  belongs_to :week
  belongs_to :pool

  def self.insert_week(pool_id="", week_id="", temp_user_id="", temp_winner="")
    complete_week = self.new
    complete_week.pool_id = pool_id
    complete_week.week_id = week_id
    complete_week.user_id =temp_user_id
    complete_week.week_winner = temp_winner
    complete_week.complete = true
    complete_week.save
  end
end
