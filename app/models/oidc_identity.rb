class OidcIdentity < ApplicationRecord
  belongs_to :user

  validates :provider, :issuer, :uid, presence: true
  validates :uid, uniqueness: { scope: [ :provider, :issuer ] }
  validates :user_id, uniqueness: { scope: [ :provider, :issuer ] }
end
