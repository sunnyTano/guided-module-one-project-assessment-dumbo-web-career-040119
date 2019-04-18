class Room < ActiveRecord::Base
    has_many :bookings
    has_many :guests, through: :bookings

    def self.display_names
        counter = 0
        # i = 0
        self.all.map do |room|
            puts #{i} room.room_type
            counter += 1 
            # binding.pry
        end
    end
end 

