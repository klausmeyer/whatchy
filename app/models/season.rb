class Season < ApplicationRecord
  belongs_to :show
  has_many :episodes

  scope :without_specials, -> () { where.not(number: 0) }
  scope :sorted_by_number, -> () { order(number: :desc) }

  # TODO: Move this to a helper / query-object / whatever
  def unseen_episodes_for?(user:)
    episodes.joins(:episode_states).where("episode_states.user_id = ? AND episode_states.seen_at IS NULL", user.id).any?
  end
end
