class CreateBookings < ActiveRecord::Migration[5.2]

  def change
    create_table :bookings do |t|
      t.datetime :checkin_date
      t.datetime :checkout_date
      t.integer :guest_id
      t.integer :room_id
  end
end

end 


