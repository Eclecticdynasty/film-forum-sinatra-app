class UpdatesController < ApplicationController
enable :sessions
  # GET: /updates
  get "/updates" do
    if logged_in?
      @user = current_user
      @updates = Update.all
      erb :'/updates/updates'
    else
      redirect '/login'
    end
  end

  #Create
  get "/updates/new" do
    if logged_in?
      erb :"/updates/new"
    else
      redirect '/login'
    end
  end

  post "/updates" do
    if params[:content] == ""
    redirect "/updates/new"
  else
    @update = current_user.updates.create(:content => params[:content])
    redirect to "/updates/#{@update.id}"
    end
  end

  get "/updates/:id" do
    if logged_in?
      @update = Update.find_by_id(params[:id])
      erb :"/updates/index"
    else
      redirect '/login'
    end
  end

  # Edit
  get "/updates/:id/edit" do
    @update = Update.find_by_id(params[:id])
    if logged_in?
      erb :"/updates/edit"
    else
      redirect '/login'
    end
  end

  patch "/updates/:id" do
    if params[:content] == ""
      redirect '/updates/#{params[:id]}/edit'
    else
      @update = Update.find_by_id(params[:id])
      @update.content = params[:content]
      @update.save
      redirect "/updates/#{@update.id}"
    end
  end

  # DELETE

  delete "/updates/:id/delete" do
      @update = Update.find_by_id(params[:id])
      if logged_in? && @update.user_id == current_user.id
        @update.delete
        redirect to '/updates'
      else
      redirect to '/login'
  end
end

end
