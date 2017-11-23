

class UsersController < ApplicationController
  use Rack::Flash

  # Signup
  get "/signup" do
    if logged_in?
      redirect "/users/#{@user.id}"
    else
      erb :'/users/new'
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:message] = "Must fill in all fields."
      redirect '/signup'
    elsif User.find_by(:username => params[:username]) != nil
      flash[:message] = "Username already registered."
      redirect '/login'
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    end
  end

  #Login

  get '/login' do
    if logged_in?
      redirect'/updates'
    else
      erb :'/users/login'
    end
  end

    post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else
      flash[:message] = "Incorrect login details."
      redirect '/signup'
    end
  end

   #Logout 

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/'
    else
      redirect "/users/#{@user.id}"
    end
  end

  #Show
  get "/users/:id" do
    @user = User.find_by_id(params[:id])
    erb :"/users/show"
  end

end