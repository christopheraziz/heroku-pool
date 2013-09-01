class SchedulesUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :schedule
  belongs_to :week

  def self.get_wins(user_id="", week_id="", pool_id="")
    win_counter = 0
    test_for_wins = self.where(:user_id => user_id, :week_id => week_id, :pool_id => pool_id)
    test_for_wins.each do |game|
      if game.pick == game.winner
        win_counter += 1
      end
    end
    return win_counter
  end

end
