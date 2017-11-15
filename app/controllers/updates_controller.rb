class UpdatesController < ApplicationController

  # GET: /updates
  get "/updates" do
    if logged_in?
      @user = current_user
      @updates = Update.all
      erb :'/updates/show'
    else
      redirect '/login'
    end
  end

  #Create
  get "/updates/new" do
    if logged_in?
      erb :"/updates/new"
    else
      
    end
    
  end

  # POST: /updates
  post "/updates" do
    if params[:content] == ""
    redirect "/updates/new"
  else
    @update = Update.create(:content => params[:content])
    current_user.updates << @update
    end
  end
  # GET: /updates/5
  get "/updates/:id" do
    erb :"/updates/show.html"
  end

  # GET: /updates/5/edit
  get "/updates/:id/edit" do
    erb :"/updates/edit.html"
  end

  # PATCH: /updates/5
  patch "/updates/:id" do
    redirect "/updates/:id"
  end

  # DELETE: /updates/5/delete
  delete "/updates/:id/delete" do
    redirect "/updates"
  end
end
