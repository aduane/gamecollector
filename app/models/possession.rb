class Possession < ActiveRecord::Base
  belongs_to :list
  validates :gbd_id, presence: true

  def game
    @game ||= Game.from_possession(self)
  end
end
