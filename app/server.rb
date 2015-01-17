require 'sinatra'
require 'data_mapper'
require 'rack-flash'

require_relative 'data_mapper_setup'
require './models/user'

class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :sign_up
  end

  post '/user/sign_up' do
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

end