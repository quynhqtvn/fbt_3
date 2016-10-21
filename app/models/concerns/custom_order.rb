module CustomOrder
  extend ActiveSupport::Concern

  included do
    scope :latest, ->{order created_at: :desc}
    scope :sort_by_title, ->{order title: :asc}
  end
end
