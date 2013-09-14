class AccessController < ApplicationController
  layout 'main'
  def index
    render('menu')
  end

  def menu
    #display text and links
    @image_file = User.get_user_photo(session[:user_id])
    id_array = Array.new
    user_pools = UsersPool.where(:user_id => session[:user_id])
    if user_pools
      user_pools.each do |p|
        id_array.push(p.pool_id)
      end
    end
    test_pools = Pool.where.not(:id => id_array)
    @last_winner = WeeksPool.where(:pool_id => id_array, :complete => true).max

    @input = test_pools
    @pools = user_pools
  end

  def admin
    @weeks = Week.all
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
    if params[:poolpicks]
      name = Pool.find(params[:poolpicks].first.first)
      params[:poolpicks].each do |t|
        if t.last == "1"
          join = UsersPool.new
          join.user_id = session[:user_id]
          join.pool_id = t.first
          join.pool_name = name.pool_name
          join.save
        end
      end
    end
    redirect_to(:action => 'menu')
  end

  def upload_image
    uploaded = params[:upload][:picture]
    full_path = uploaded.original_filename
    get_user = User.find(session[:user_id])
    get_user.update(image: full_path.to_s)
    File.open(Rails.root.join('app', 'assets','images', uploaded.original_filename), 'wb') do |file|
      file.write(uploaded.read)
    end
    redirect_to(:action => 'menu')
  end
  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    redirect_to(:action => 'login')
  end

end
