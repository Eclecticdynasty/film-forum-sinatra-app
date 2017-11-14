class UsersController < ApplicationController
  enable :sessions

  # Signup
  get "/signup" do
    if logged_in?
      erb :'/users/new.html'
    else
      redirect '/users/show.html'
    end
  end

  post "/signup" do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect "/users/show.html"
    else
      erb :'/users/new.html'
    end
  end



  # # GET: /users/5
  # get "/users/:id" do
  #   erb :"/users/show.html"
  # end

end