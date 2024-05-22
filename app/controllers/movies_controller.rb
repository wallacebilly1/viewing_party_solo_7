class MoviesController < ApplicationController
  def index
    @facade = MovieSearchFacade.new(params[:keyword])
  end

  def show
    @facade = MovieFacade.new(params[:id])
  end
end