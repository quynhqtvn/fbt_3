class Comment < ApplicationRecord
  include CustomOrder
  belongs_to :user
  belongs_to :review

  validates :content, presence: true
end
