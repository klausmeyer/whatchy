class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [ :openid_connect ]

  has_many :oidc_identities, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :shows, through: :subscriptions
  has_many :favourite_shows, through: :favourites, source: :show
  has_many :episode_states, dependent: :destroy

  before_validation :normalize_email

  def gravatar_hash
    Digest::MD5.hexdigest(email.downcase)
  end

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end
