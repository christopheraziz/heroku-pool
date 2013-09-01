class Schedule < ActiveRecord::Base
  belongs_to :weeks

  has_many :schedules_users
  has_many :users, :through => :schedules_users

  #user makes weekly picks
  def self.make_picks(picks="", user_id="", pool_id="", week_id="")
    picks.each do |key, value|
      insert = SchedulesUser.new
      insert.user_id = user_id
      insert.schedule_id = key
      insert.pool_id = pool_id
      insert.week_id = week_id
      insert.pick = value
      insert.save
    end
  end

  def self.update_winners(picks="", pool_id="", week_id="")
    user_ids = Array.new
    winners = Array.new
    game_ids = Array.new

    picks.each do |key, value|
      game_ids.unshift(key)
      winners.unshift(value)
    end
    number_games = game_ids.count
    user_pools = UsersPool.where(:pool_id => pool_id)
    user_pools.each do |u|
      user_ids.unshift(u.user_id)
    end

    #update all team winners for the week for the entire pool
    picks.each do |key, value|
      games = SchedulesUser.where(:schedule_id => key, :week_id => week_id, :pool_id => pool_id)
      games.update_all(winner: value)
    end

    #generate user and pool stats for the week for each user
    #making new entries for SchedulesUser and  UsersWeek
    user_ids.each do |user|
      @win_counter = SchedulesUser.get_wins(user, week_id, pool_id)
      UsersWeek.insert_user_stats(user, week_id, pool_id, number_games, @win_counter)
    end

    #determine winner of the pool for the week and
    # make new entries for the week in WeeksPool

    winners_hash = Hash.new
    get_winner = UsersWeek.where(:pool_id => pool_id, :week_id => week_id)
    get_winner.each do |w|
      winners_hash[w.user_id] = w.total_wins
    end
    winning_id = Array.new
    temp_winner = nil
    high_score = 0
    winners_hash.each do |key, value|
      if !temp_winner
        temp_winner = key
        high_score = value
        winning_id.push(temp_winner)
      else
        if value > high_score
          temp_winner = key
          high_score = value
          winning_id.clear
          winning_id.push(temp_winner)
        elsif value == high_score
          winning_id.push(key)
        end
      end
    end

    temp_user_id = nil
    temp_winner = nil
    if winning_id.count > 1
      winning_id.each do |win_user|
        user = User.find(win_user)
        temp_winner += user.first_name+' '
      end
    else
      user = User.find(winning_id.first)
      temp_winner = user.first_name
      temp_user_id = winning_id.first
    end
    WeeksPool.insert_week(pool_id, week_id, temp_user_id, temp_winner)

    return winners_hash
  end

  def self.weekly_winners(picks="", id="")
  end

  def self.valid_form(picks="")
    num_games = Schedule.where(:week_id => self.find_week(picks.keys.first)).count
    num_picks = picks.count
    incomplete_form = false

    if num_games != num_picks
      incomplete_form = true
    end

    picks.each do |key, value|
      if key == nil
        incomplete_form = true
      end
    end

    if incomplete_form
      return false
    else
      return true
    end

  end

  def self.find_week(schedule_id="")
    first_game = Schedule.find(schedule_id)
    return first_game.week_id
  end

end
