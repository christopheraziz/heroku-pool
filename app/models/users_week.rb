class UsersWeek < ActiveRecord::Base
  belongs_to :user
  belongs_to :week

  def self.insert_user_stats(user_id="", week_id="", pool_id="", total_games="", total_wins="")
    losses = total_games - total_wins
    percentage = 0
    if total_wins == 0
      percentage = 0
    else
      percentage = ((total_wins * 100) /  total_games)
    end
    name = User.get_user_name(user_id)
    insert = self.new
    insert.user_id = user_id
    insert.week_id = week_id
    insert.pool_id = pool_id
    insert.name = name
    insert.total_games = total_games
    insert.total_wins = total_wins
    insert.total_losses = losses
    insert.win_percentage = percentage
    insert.complete = true
    insert.save
  end

  def self.get_completed_week_stats(pool_id="")
    #each hash(stat_hash) key represents week id, value is an array of user records
    test = Array.new
    stat_hash = Hash.new
    all_users = self.where(:pool_id => pool_id).order("week_id ASC")
    num_complete = all_users.count("DISTINCT week_id")
    (1..num_complete).each do |week|
      user_stats = Array.new
      all_users.each do |user|
        if user.week_id == week
          name = User.get_user_name(user.user_id)
          user_stats.push(user)
          stat_hash[week] = user_stats, name
        end
      end
    end
    test.push(num_complete)
    return stat_hash
  end


end
