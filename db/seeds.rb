# require 'date'
# require 'pry'

Guest.destroy_all
Room.destroy_all
Booking.destroy_all

susan = Guest.create(username: "SUSAN TAN")
jelly = Guest.create(username: "JELLY DOE")
joe = Guest.create(username: "JOE DOE")

room1 = Room.create(room_type: "Super Luxury Panda Room", capacity: 10)
room2 = Room.create(room_type: "Silver Villa Sloth Room", capacity: 8)
room3 = Room.create(room_type: "Gold Ultra Pig Room", capacity: 6)
room4 = Room.create(room_type: "Great Standard Puppy Room", capacity: 4)

Booking.create(checkin_date: "2019/01/20", checkout_date: "2019/02/21", guest_id: susan.id, room_id: room1.id)
Booking.create(checkin_date: "2019/02/20", checkout_date: "2019/03/20", guest_id: jelly.id, room_id: room2.id)
Booking.create(checkin_date: "2019/03/20", checkout_date: "2019/04/20", guest_id: joe.id, room_id: room3.id)
Booking.create(checkin_date: "2019/04/20", checkout_date: "2019/05/20", guest_id: jelly.id, room_id: room4.id)

# checkin = {
#     available: {"January" => ["1/11/20", "1/29/20"], "febuary" => ["2/1/20", "2/14/20"]},
#     not_available: {"March" => ["3/1/20", "3/14/20"], "april" => ["4/1/20", "4/15/20"]}
# }

# booking1 = checkin[:available].map do |month, check_in|
#     binding.pry
#     Booking.create(checkin_date: check_in[0], checkout_date: check_in[1], guest_id: susan.id, room_id: room3.id)
# end

# binding.pry
# require 'date'

# Date.parse('2/9/2007').to_s
# # => "2007-02-09"
# DateTime.parse('02-09-2007 12:30:44 AM').to_s
# # => "2007-09-02T00:30:44+00:00"

# DateTime.parse('02-09-2007 12:30:44 PM EST').to_s
# # => "2007-09-02T12:30:44-0500"
# Date.parse('Wednesday, January 10, 2001').to_s
# # => "2001-01-10"
