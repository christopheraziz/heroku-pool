class SchedulesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :schedule
  belongs_to :week

  def self.update_winners(ids="", wins="", game_id="")
    #SchedulesUser.user_id = User.id
    #games = SchedulesUser.where(:user_id => ids)

=begin
ids.each do |u|
      index = 0
      games = SchedulesUser.where(:user_id => u)
      games.each do |g|
        if g.pick == wins[index]
          game = SchedulesUser.find(game_id[index])
          game.winner = wins[index]
          game.save
        end
        index += 1
      end
    end
		ids.each do |u|
			index = 0
			games.each do |g|
				if g.user_id == u
					if g.pick == wins[index]
						g.winner = wins[index]
						insert = SchedulesUser.find_by_
					end
				end
				index += 1
			end
		end
=end
    return false
  end

end
