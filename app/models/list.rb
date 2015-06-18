class List < ActiveRecord::Base
  belongs_to :user
  has_many :possessions

  def games
    @games ||= possessions.map(&:game)
  end
end
