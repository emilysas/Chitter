require 'rubygems'
require 'sinatra'
require 'active_support'
require 'data_mapper'
require 'rack-flash'

require_relative 'data_mapper_setup'
require './models/user'
require './models/peep'

class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/users/new' do
    session.clear
    @user = User.new
    erb :sign_up
  end

  post '/users/registered' do
    @user = User.create(:name => params[:name],
                :username => params[:username],
                :email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :sign_up
    end
  end

  get '/sessions/new' do
    session.clear
    erb :sign_in
  end

  get '/sessions/peep' do
    erb :peep
  end

  post '/sessions' do
    username, password = params[:username], params[:password]
    user = User.authenticate(username, password)
    if user
      session[:user_id] = user.id
      session[:user_username] = user.username
      redirect to ('/')
    else
      flash[:errors] = ["the username or password is incorrect"]
      erb :sign_in
    end
  end

  post '/sessions/posted' do
    @peep = Peep.create(:user_id => params[:user_id],
                :posted_by => params[:posted_by],
                :content => params[:content],
                :created_at => Time.now)
    if @peep.save
      redirect to('/')
    else
      flash.now[:errors] = @peep.errors.full_messages
      erb :peep
    end
  end

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

end