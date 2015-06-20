class VisitorsController < ApplicationController
  skip_before_filter :authenticate_user!
  
  def index
    redirect_to my_collection_url if user_signed_in?
  end
end
