class Schedule < ActiveRecord::Base
  belongs_to :weeks

  has_many :schedules_users
  has_many :users, :through => :schedules_users
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
    number_games = game_ids.count
    picks.each do |key, value|
      game_ids.unshift(key)
      winners.unshift(value)
    end

    user_pools = UsersPool.where(:pool_id => pool_id)
    user_pools.each do |u|
      user_ids.unshift(u.user_id)
    end

    index = 0
    game_ids.each do |temp|
      games = nil
      string_temp = winners[index]
      games = SchedulesUser.where(:schedule_id => temp, :week_id => week_id, :pool_id => pool_id)
      games.update_all(winner: string_temp)
      index += 1
    end
    user_ids.each do |user|
      @win_counter = 0
      test_for_win = SchedulesUser.where(:user_id => user, :week_id => week_id, :pool_id => pool_id)
        test_for_win.each do |test|
           if test.pick == test.winner
             @win_counter += 1
           end
        end
      #update_week_stats = UsersWeek.find_by_week_id(week_id)
    end
    ha_ha = Array.new
    ha_ha.push(@win_counter)

    return ha_ha
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
