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

     ######################redo migration to change ool to string for winner
    #### try usinf update.all = game id then set the string value to winner
    game_ids = Array.new
    hashes = Hash.new

    picks.each do |key, value|
      hashes[key] ={:winner => value}
    end
    picks.each do |key, value|
      winners.unshift(value)
      game_ids.unshift(key)
    end
    #UsersSchedule.schedule_id.update(hashes.keys, hashes.values)
    user_pools = UsersPool.where(:pool_id => pool_id)
    user_pools.each do |u|
      user_ids.unshift(u.user_id)
    end
     out = nil
    user_ids.each do |u|
      index = 0
      games = SchedulesUser.where(:user_id => u, :week_id => week_id)
      out = games
      games.each do |g|
        update = nil
        update = SchedulesUser.where(:user_id => u, :schedule_id => g.schedule_id)
        update.each do |up|
          if up.pick == winners[index]
            up.winner = true
            up.save
          else
            up.winner = false
            up.save
          end
        end
        #if g.pick == winners[index]
          #game = SchedulesUser.find(game_ids[index])
          #game.winner = winners[index]
          #game.save
        #end
        index += 1
      end
    end


    #test_find = UsersPool.find(2)
    test = SchedulesUser.update_winners(user_ids, winners, game_ids)
    return winners
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
