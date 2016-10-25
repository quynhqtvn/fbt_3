class Review < ApplicationRecord
  include CustomOrder
  include PublicActivity::Model

  belongs_to :user
  belongs_to :category_review

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: {maximum: 100}
  validates :content, presence: true

  has_attached_file :image, styles: {small: "64x64", med: "100x100", large: "300x300"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
