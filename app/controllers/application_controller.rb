require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    current_user
    current_user
    current_user
    erb :'/index'
  end

 

helpers do

  def logged_in?
    !!session[:user_id]
  end

  def current_user
     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end


end
