class User < ActiveRecord::Base
  has_many :schedules_users
  has_many :schedules, :through => :schedules_users

  has_many :users_weeks
  has_many :weeks, :through => :users_weeks

  has_many :users_pools
  has_many :pools, :through => :users_pools


  def self.authenticate(email="", password="")
    user = self.find_by_email(email)
    if user.password == password
      return user
    else
      return false
    end
  end

  def self.get_user_photo(user_id="")
    return self.find(user_id).image
  end

  def self.get_user_name(user_id='')
    return self.find(user_id).first_name
  end

end
