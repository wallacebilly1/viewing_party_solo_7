class SimilarController < ApplicationController
  def index
    @facade = MovieFacade.new(params[:movie_id])
  end
end