class AccessController < ApplicationController
  layout 'main'
  def index
    render('menu')
  end

  def menu
    #display text and links
    id_array =Array.new

    @playable_weeks = Week.get_weeks
    user_pools = UsersPool.where(:user_id => session[:user_id])
    if user_pools
      user_pools.each do |p|
        id_array.push(p.pool_id)
      end
    end
    test_pools = Pool.where.not(:id => id_array)
    @id_test = id_array
    @pools = user_pools
    @input = test_pools
  end

  def admin
    @weeks = Week.get_weeks
    @pools = Pool.all
  end

  def login
    if session[:user_id]
      redirect_to(:action => 'menu')
    end
  end

  def attempt_login
    @problem = false
    authorized_user = User.authenticate(params[:signin][:email], params[:signin][:password])
    if authorized_user
      session[:user_id] = authorized_user.id
      session[:user_name] = authorized_user.first_name
      redirect_to(:action => 'menu')
    else
      @problem = true
      render :action => 'login'
    end
  end

  def sign_up
    if session[:user_id]
      redirect_to(:action => 'menu')
    end
    @password_error = false
    @incomplete_form_error = false
    @user_created = false
    incomplete_form = false

    if params[:user] != nil
      if params[:user][:first_name] == ""
        incomplete_form = true
      elsif params[:user][:last_name] == ""
        incomplete_form = true
      elsif params[:user][:email] == ""
        incomplete_form = true
      elsif params[:user][:password] == ""
        incomplete_form = true
      elsif params[:user][:verify_password] == ""
        incomplete_form = true
      end

      if incomplete_form
        @incomplete_form_error = true
        render :action => 'sign_up'
      else
        if params[:user][:password] != params[:user][:verify_password]
          @password_error = true
          render :action => 'sign_up'
        else
          user = User.new(:first_name => params[:user][:first_name], :last_name => params[:user][:last_name], :email => params[:user][:email], :password => params[:user][:password], :image => nil)
          user.save
          @user_created = true
          session[:user_id] = user.id
          session[:user_name] = user.first_name
          redirect_to(:action => 'menu')
        end
      end
    end
  end

  def join_pool
    test_debug = true
    if test_debug
      name = Pool.find(params[:poolpicks].first.first)
      number_weeks = Week.all
      params[:poolpicks].each do |t|
        if t.last == "1"
          join = UsersPool.new
          join.user_id = session[:user_id]
          join.pool_id = t.first
          join.pool_name = name.pool_name
          join.save
          counter = 1
          (1..number_weeks.count).each do |insert|
            insert = UsersWeek.new
            insert.user_id = session[:user_id]
            insert.pool_id = params[:poolpicks].first.first
            insert.week_id = counter
            insert.complete = false
            insert.save
            counter += 1
          end
        end
      end
      redirect_to(:action => 'menu')
    else
      @test = params[:poolpicks]
    end #test_debug

  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to(:action => 'login')
  end

end
