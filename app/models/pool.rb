class Pool < ActiveRecord::Base
  has_many :users_pools
  has_many :users, :through => :users_pools

  has_many :weeks_pools
  has_many :weeks, :through => :weeks_pools
end
