require 'sinatra'
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
    erb :sign_in
  end

  post '/sessions' do
    username, password = params[:username], params[:password]
    user = User.authenticate(username, password)
    if user
      session[:user_id] = user.id
      redirect to ('/')
    else
      flash[:errors] = ["the username or password is incorrect"]
      erb :sign_in
    end
  end

  def current_user
    @current_user ||= User.get(session[:user_id]) if session[:user_id]
  end

end