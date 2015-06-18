class Game
  include ActiveModel::Model

  attr_accessor :gbd_id, :possession

  def self.from_gbd_id(gbd_id)
    new(gbd_id: gbd_id)
  end

  def self.from_possession(possession)
    new(gbd_id: possession.gbd_id, possession: possession)
  end

  def ==(other)
    self.gbd_id == other.gbd_id
  end

  def title
    api_data.title
  end

  private

  def api_data
    @api_data ||= TheGamesDB::Game.find(self.gbd_id)
  end
end
