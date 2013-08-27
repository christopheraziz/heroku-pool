class Schedule < ActiveRecord::Base
  belongs_to :weeks

  has_many :schedules_users
  has_many :users, :through => :schedules_users
end
