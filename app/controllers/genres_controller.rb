class GenresController < ApplicationController

  # GET: /genres
  get "/genres" do
    @genres = Genre.all
    erb :"/genres/index"
  end

  # GET: /genres/5
  get "/genres/:id" do
    @genre = Genre.find_by_id(params[:id])
    erb :"/genres/show.html"
  end

end
