class CollectionController < ApplicationController

  def show
    @user = current_user
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
