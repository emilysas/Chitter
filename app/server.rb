require 'rubygems'
require 'sinatra'
require 'active_support'
require 'data_mapper'
require 'rack-flash'

require_relative 'data_mapper_setup'
require './app/helpers/ago'
require './app/helpers/current_user'
require './models/user'
require './models/peep'
require './models/reply'

class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  use Rack::Flash
  include CurrentUser

  get '/' do
    @peeps = Peep.all_in_chron
    erb :index
  end

  get '/users/new' do
    session.clear
    @user = User.new
    erb :sign_up
  end

  post '/users/registered' do
    @user = user_create
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :sign_up
    end
  end

  get '/users/search' do
    erb :search
  end

  

  post '/users/details/?:user' do
    @searched = params[:user]
    @followee = User.all.first(:username => @searched)
    @peeps = Peep.all_by_user_in_chron(@searched)
    erb :user_info
  end

  post '/users/details/' do
    @searched = params[:search_username]
    @followee = User.all.first(:username => @searched)
    @peeps = Peep.all_by_user_in_chron(@searched)
    erb :user_info
  end

  get '/users/follow/:username' do
    followee = User.all.first(:username => params[:username])
    current_user.follow(followee)
    redirect '/'
  end

  get '/users/followers/:username' do
    @followers = User.all.first(:username => params[:username]).followers
    erb :followers
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

  get '/sessions/new' do
    session.clear
    erb :sign_in
  end

  get '/sessions/peep' do
    erb :peep
  end

  post '/sessions/posted' do
    @peep = peep_create
    if @peep.save
      redirect to('/')
    else
      flash.now[:errors] = @peep.errors.full_messages
      erb :peep
    end
  end

  get '/sessions/reply/:peep_id' do
    erb :reply
  end

  post '/sessions/replied/:peep_id' do
    @reply = reply_create
    if @reply.save
      redirect to('/')
    else
      flash.now[:errors] = @reply.errors.full_messages
      erb :reply
    end
  end

  get '/sessions/show_reply/:peep_id' do
    erb :replies
  end

  get '/sessions/end' do
    session.clear
    redirect '/'
  end

  post '/sessions/favourite/:peep_id' do
    @peep = Peep.all(:id => params[:peep_id])
    @peep.first.favourites+=1
    @peep.save
    redirect '/'
  end

end