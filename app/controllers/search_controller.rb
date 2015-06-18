class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    @search_results = TheGamesDB::Game.search(name: params[:search_term])
  end
end
