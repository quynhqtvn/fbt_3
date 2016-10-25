class AddParamsStatusTransactionIdPurchasedAtToBookTours < ActiveRecord::Migration[5.0]
  def change
    add_column :book_tours, :notification_params, :text
    add_column :book_tours, :status, :string
    add_column :book_tours, :transaction_id, :string
    add_column :book_tours, :purchased_at, :datetime
  end
end
