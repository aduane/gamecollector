class List < ActiveRecord::Base
  belongs_to :user
  has_many :possessions

  def games(possessions_query_options = {})
    @games ||= possessions.where(possessions_query_options).map(&:game)
  end
end
