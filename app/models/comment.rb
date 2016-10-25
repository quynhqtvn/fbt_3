class Comment < ApplicationRecord
  include CustomOrder
  include PublicActivity::Model

  belongs_to :user
  belongs_to :review

  validates :content, presence: true
end
