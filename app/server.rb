require 'sinatra'
require 'data_mapper'

require_relative 'data_mapper_setup'
require './models/user'

class Chitter < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :sign_up
  end

  post '/user/sign_up' do
    User.create(:name => 'Emily')
  end


end