class SchedulesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :schedule
  belongs_to :week
end
