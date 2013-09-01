class Week < ActiveRecord::Base
  has_many :schedules

  has_many :users_weeks
  has_many :users, :through => :users_weeks

  has_many :weeks_pools
  has_many :pools, :through => :weeks_pools

  def self.get_playable_weeks(pool_id="")
    week_ids = Array.new
    completed_weeks = WeeksPool.where(:pool_id => pool_id)
    completed_weeks.each do |id|
      week_ids.unshift(id.week_id)
    end
    if completed_weeks != nil
      return Week.where.not(:id => week_ids).limit(2)
    else
      return Week.all.limit(2)
    end
  end

end
