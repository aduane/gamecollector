class Possession < ActiveRecord::Base
  belongs_to :list

  def game
    @game ||= Game.from_possession(self)
  end
end
