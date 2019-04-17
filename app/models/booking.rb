class Booking < ActiveRecord::Base
    belongs_to :room
    belongs_to :guest

    def self.new_booking(checkin, checkout, user, temp)
        new_user = self.create(checkin_date: checkin, checkout_date: checkout, guest_id: user.id, room_id: temp)
    end

end 


