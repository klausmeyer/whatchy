class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :show

  validates :user, presence: true, uniqueness: { scope: :show }
  validates :show, presence: true, uniqueness: { scope: :user }
end
