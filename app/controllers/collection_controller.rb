class CollectionController < ApplicationController
  skip_before_filter :authenticate_user!, only: :collection

  def my_collection
    @user = current_user
    set_games_for_user @user
    render :show
  end

  def collection
    @user = User.where(uid: params[:id]).first!
    set_games_for_user @user
    render :show
  end

  def add_to_collection
    @possession = current_user.add_to_collection(possession_parameters[:gbd_id], possession_parameters[:game_title], possession_parameters[:game_platform])
    respond_to do |format|
      format.html do
        if @possession.persisted?
          redirect_to my_collection_url, notice: add_to_collection_success_message
        else
          redirect_to :back, alert: add_to_collection_failure_message
        end
      end

      format.js do
        if @possession.persisted?
          render "add_to_collection_success"
        else
          render "add_to_collection_failure", locals: { message: add_to_collection_failure_message }
        end
      end
    end
  end

  def remove_from_collection
    @gbd_id = possession_parameters[:gbd_id]
    current_user.remove_from_collection(@gbd_id)
    respond_to do |format|
      format.html do
        redirect_to my_collection_url
      end
      format.js do
        render "remove_from_collection"
      end
    end
  end

  private

  def set_games_for_user(user)
    if params[:platform].present? && params[:platform] != "All platforms"
      @games = user.owned_games(game_platform: params[:platform])
    else
      @games = user.owned_games
    end
  end

  def possession_parameters
    params.permit(:gbd_id, :game_title, :game_platform)
  end

  def add_to_collection_success_message
    "#{possession_parameters[:game_title]}(#{possession_parameters[:game_platform]}) was added to your collection."
  end

  def add_to_collection_failure_message
    "There were problems adding #{possession_parameters[:game_title]}(#{possession_parameters[:game_platform]}) to your collection."
  end
end
