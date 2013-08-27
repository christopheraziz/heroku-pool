class UsersPool < ActiveRecord::Base
  belongs_to :user
  belongs_to :pool
end
