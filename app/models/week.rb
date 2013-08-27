class Week < ActiveRecord::Base
  has_many :schedules

  has_many :users_weeks
  has_many :users, :through => :users_weeks

  has_many :weeks_pools
  has_many :pools, :through => :weeks_pools
end
