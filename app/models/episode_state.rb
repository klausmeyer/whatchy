class EpisodeState < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  validates :user,    presence: true, uniqueness: { scope: :episode }
  validates :episode, presence: true, uniqueness: { scope: :user }
end
