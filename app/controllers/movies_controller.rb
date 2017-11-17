class MoviesController < ApplicationController

  # index
  get "/movies" do
    @movies = Movie.all
    erb :"/movies/index"
  end

  # new
  get "/movies/new" do
    @genres = Genre.all
    erb :"/movies/new"
  end

    get '/movies/:id' do
     @movie = Movie.find_by_id(params[:id])
     erb :"/movies/show"
   end

  post "/movies" do
    if logged_in?
      if params[:name] == "" 
        redirect '/movies/new'
      else
        @movie = Movie.new
        @movie.name = params[:name]
        @movie.user = current_user
        @movie.genre_id = params[:genre_id]
        @movie.save
      end
    end
  end


  # GET: /movies/5/edit
  get "/movies/:id/edit" do
    erb :"/movies/edit.html"
  end

  # PATCH: /movies/5
  patch "/movies/:id" do
    redirect "/movies/:id"
  end

  # DELETE: /movies/5/delete
  delete "/movies/:id/delete" do
    redirect "/movies"
  end
end
