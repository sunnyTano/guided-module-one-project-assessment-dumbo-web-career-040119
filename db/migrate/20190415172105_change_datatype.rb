class ChangeDatatype < ActiveRecord::Migration[5.2]
  
  def change 
    change_column :bookings, :checkin_date, :date
    change_column :bookings, :checkout_date, :date
  end
  
end
