class MoviesController < ApplicationController
  def index
    @keyword = params[:keyword]
  end
end