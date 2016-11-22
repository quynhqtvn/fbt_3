class Tour < ApplicationRecord
  ratyrate_rateable "rating"
  belongs_to :category_tour

  has_many :book_tours
  has_many :ratings, dependent: :destroy
  has_many :images_tours, dependent: :destroy

  validates :people_number, presence: true,
    numericality: {only_integer: true}

  validates :price, presence: true,
    numericality: {only_float: true}

  scope :recent, ->{order created_at: :desc}
  accepts_nested_attributes_for :images_tours
end
