class WeeksPool < ActiveRecord::Base
  belongs_to :week
  belongs_to :pool
end
