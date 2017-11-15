class UsersController < ApplicationController
  enable :sessions

  # Signup
  get "/signup" do
    if logged_in?
      redirect'/updates'
    else
      erb :'/users/show'
    end
  end

  post "/signup" do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/signup'
    else
      erb :'/users/new.html'
    end
  end

  #Login

  get '/login' do
    if logged_in?
      erb :'/users/login'
    else
      erb :'/users/show'
    end
  end

    post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/updates'
    else
      redirect '/signup'
    end
  end

   #Logout 

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end




end