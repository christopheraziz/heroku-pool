class PoolsController < ApplicationController
  def make_pool
    #params[:new_pool][:pool_name]
    new_pool = Pool.new
    new_pool.pool_name = params[:new_pool][:pool_name]
    new_pool.save
    last_id = Pool.all
    number_weeks = Week.all
    counter = 1
    (1..number_weeks.count).each do |insert|
      insert = WeeksPool.new
      insert.pool_id = last_id.last.id
      insert.week_id = counter
      insert.complete = false
      insert.save
      counter += 1
    end
    redirect_to(:controller => "access", :action => "admin")
  end
end
