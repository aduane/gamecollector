class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def collection
    @collection ||= Collection.where(user_id: self.id).first_or_create!
  end

  def owned_games
    @owned_games ||= collection.games
  end

  def owns_game?(game)
    owned_games.map(&:gbd_id).include?(game.gbd_id.to_i)
  end

  def add_to_collection(gbd_id, title = "Title not found", platform = "Platform not found")
    collection.possessions.create(gbd_id: gbd_id, game_title: title, game_platform: platform)
  end

  def remove_from_collection(gbd_id)
    collection.possessions.where(gbd_id: gbd_id).destroy_all
  end

  # generated omniauth code

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

end
