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
    if logged_in?
    erb :"/movies/new"
  else
    redirect '/login'
  end
end

  post "/movies" do
    if logged_in?
     if params[:title] == "" || params[:director] == ""
       redirect '/movies/new'
     elsif current_user.movies.find_by(title: params[:title]) == nil
      @movie = Movie.new
      @movie.title = params[:title]
      @movie.director = params[:director]
      @movie.user = current_user
      @movie.genre_id = params[:genre_id]
      @movie.save
      redirect "/movies"
      else
        @movie = current_user.movies.find_by(title: params[:title])
        flash[:message] = "Movie already exists."
        redirect to 'movies/new'
      end
      end
  end

    get '/movies/:id' do
     @movie = Movie.find_by_id(params[:id])
     erb :"/movies/show"
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

  # PATCH
  patch "/movies/:id" do
    if logged_in?
      @movie = Movie.find_by_id(params[:id])
      if @movie.user == current_user
        @movie.update(params[:movie])
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

  # DELETE
  delete "/movies/:id/delete" do
   @movie = Movie.find_by_id(params[:id])
    if logged_in? && @movie.user.id == current_user.id
      @movie.delete
      redirect '/users/show'
    else
      redirect '/login'
    end
  end
end
