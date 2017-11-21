class MoviesController < ApplicationController
  enable :sessions
  use Rack::Flash

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

  # edit
  get "/movies/:id/edit" do
    @movie = Movie.find_by_id(params[:id])
    @genres = Genre.all
    if @movie.user == current_user
      erb :"/movies/edit"
    else
      redirect "/movies/#{@movie.id}"
    end
  end

  # PATCH: /movies/5
  patch "/movies/:id" do
    if logged_in?
      @movie = Movie.find_by_id(params[:id])
      if @movie.user == current_user
        @movie.update(params[:movie])
        flash[:message] = "Movie added!"
        redirect "/movies/#{@movie.id}"
      else
        flash[:message] = "Movie not saved!"
        redirect '/movies'
      end
    else
      flash[:message] = "Please log-in!"
      redirect '/login'
    end
  end

  # DELETE: /movies/5/delete
  delete "/movies/:id/delete" do
    
  end
end
