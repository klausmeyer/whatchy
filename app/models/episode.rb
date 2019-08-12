class Episode < ApplicationRecord
  belongs_to :season

  def full_number
    'S%02dE%02d' % [season.number, number]
  end
end
