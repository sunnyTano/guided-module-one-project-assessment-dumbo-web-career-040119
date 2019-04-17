class ChangeColumnDataDate < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :checkin_date, :string
    change_column :bookings, :checkout_date, :string
  end
end
