class Room < ActiveRecord::Base
    has_many :bookings
    has_many :guests, through: :bookings

    def self.display_names
        counter = 1 
        self.all.map do |r|
            puts r.room_type
        end
    end 
    
end 

