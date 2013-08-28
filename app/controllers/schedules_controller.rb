class SchedulesController < ApplicationController
  layout 'main'
  def list
    #@schedules = Schedule.find(:week_id => params[:id])
    @schedules = Schedule.where('week_id = ?', params[:id]).order("id ASC")
    @this_pool_id = params[:this_pool]
    @week_id = params[:id]
  end

  def week_list
    @playable_weeks = Week.get_weeks
    session[:pool_id] = params[:id]
    @this_pool = params[:id]
  end

  def adminlist
    @update_games = Schedule.where('week_id = ?', params[:id]).order("id ASC")
    @week_id = params[:id]
    @this_pool_id = params[:this_pool]
  end

  def admin_week_list
    @playable_weeks = Week.get_weeks
    @this_pool = params[:id]
  end

  def updateweek
    session[:prev_url] = request.referer
    @problem = false
    if params[:picks] != nil
      valid = Schedule.valid_form(params[:picks])
    end

    if valid
      @record = Schedule.update_winners(params[:picks], params[:this_pool], params[:week_id])
      @test  = params[:picks]
      render(:action => 'your_picks')
    else
      redirect_to session[:prev_url]
    end

  end

  def picks

    if params[:picks] != nil
      valid = Schedule.valid_form(params[:picks])
    end

    if valid
      Schedule.make_picks(params[:picks], session[:user_id], params[:this_pool], params[:week_id])
      render(:action => 'your_picks')
    else
      redirect_to session[:prev_url]
    end

  end

  def your_picks

  end
end
