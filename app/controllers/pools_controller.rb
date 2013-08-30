class PoolsController < ApplicationController
  def make_pool
    new_pool = Pool.new
    new_pool.pool_name = params[:new_pool][:pool_name]
    new_pool.save
    redirect_to(:controller => "access", :action => "admin")
  end
end
