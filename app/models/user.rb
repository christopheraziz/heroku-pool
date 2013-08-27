class User < ActiveRecord::Base
  has_many :schedules_users
  has_many :schedules, :through => :schedules_users

  has_many :users_weeks
  has_many :weeks, :through => :users_weeks

  has_many :users_pools
  has_many :pools, :through => :users_pools
end
