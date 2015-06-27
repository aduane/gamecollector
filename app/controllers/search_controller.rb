class SearchController < ApplicationController
  def index
    @search_results = TheGamesDB::Game.search(name: params[:search_term])
  end
end
