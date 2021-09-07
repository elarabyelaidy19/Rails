class CreateKittyRentalRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :kitty_rental_requests do |t|
      t.integer :kitty_id, null: false
      t.date :end_date, null: false
      t.date :start_date, null: false
      t.string :status, null: false

      t.timestamps
    end
    add_index :kitty_rental_requests, :kitty_id
  end
end
