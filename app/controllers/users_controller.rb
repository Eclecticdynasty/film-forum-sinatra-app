class UsersController < ApplicationController
  enable :sessions

  # Signup
  get "/signup" do
    if logged_in?
      redirect'/updates'
    else
      erb :'/users/new'
    end
  end

  post "/signup" do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect '/signup'
    else
      redirect '/updates'
    end
  end

  #Login

  get '/login' do
    if logged_in?
      erb :'/updates'
    else
      erb :'/users/login'
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
      redirect to '/'
    else
      redirect'/updates'
    end
  end

  #Show
  get "/users/:id" do
    @user = User.find_by_id(params[:id])
    erb :"/users/show"
  end

end