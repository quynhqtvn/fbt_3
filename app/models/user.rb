class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :book_tours
  has_many :likes, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  scope :alphabet, ->{order :name}

  def is_user? user
    user == self
  end

  def likes? review
    review.likes.where(user_id: id).any?
  end

  class << self
    def from_omniauth access_token
      data = access_token.info
      user = User.find_by email: data["email"]
      unless user
        password = Devise.friendly_token[0,20]
        user = User.create name: data["name"], email: data["email"],
          password: password, password_confirmation: password
      end
      user
    end
  end
  mount_uploader :avatar, AvatarUploader

  scope :alphabet, ->{order :name}

  def is_user? user
    user == self
  end
end
