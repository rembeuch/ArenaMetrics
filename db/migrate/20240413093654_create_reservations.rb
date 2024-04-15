class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.string :ticket_number
      t.string :reservation_number
      t.date :reservation_date
      t.time :reservation_time
      t.string :show_key
      t.string :show_name
      t.string :representation_key
      t.string :representation_name
      t.date :representation_date
      t.time :representation_start_time
      t.date :representation_end_date
      t.time :representation_end_time
      t.decimal :price
      t.string :product_type
      t.string :sales_channel
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :address
      t.string :postal_code
      t.string :country
      t.integer :age
      t.string :gender

      t.timestamps
    end
  end
end
