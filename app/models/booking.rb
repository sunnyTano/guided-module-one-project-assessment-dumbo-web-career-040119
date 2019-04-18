class Booking < ActiveRecord::Base
    belongs_to :room
    belongs_to :guest

    def self.new_booking(checkin, checkout, user, temp)
        new_user = self.create(checkin_date: checkin, checkout_date: checkout, guest_id: user.id, room_id: temp)
    end

    def self.view_username(user)
        self.last.guest.username.upcase
        # self.guest.username.upcase
        # self.all.find_by(guest_id: (Guest.find_by(username: user)).id)
    end 

    # def find_create
    #     self.find_or_create_bycreate(checkin_date: checkin, checkout_date: checkout, guest_id: user.id, room_id: temp)
    # end
end 


