class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :shows, through: :subscriptions
  has_many :episode_states
end
