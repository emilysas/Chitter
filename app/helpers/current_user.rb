module CurrentUser

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

  def user_create
    User.create(:name => params[:name],
                :username => params[:username],
                :email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])
  end

  def peep_create
    Peep.create(:user_id => params[:user_id],
                :posted_by => params[:posted_by],
                :content => params[:content],
                :created_at => Time.now)
  end

  def reply_create
    Reply.create(:user_id => session[:user_id],
                :peep_id => params[:peep_id],
                :posted_by => session[:user_username],
                :content => params[:content],
                :created_at => Time.now)
  end

end