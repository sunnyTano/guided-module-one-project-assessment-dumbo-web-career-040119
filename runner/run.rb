require 'colorize'
require 'pry'
# require_relative '../app/models/guest'

def welcome
   puts "Welcome to My Bookings!".colorize(:cyan)
end 

def signin
   puts "Sign up with your name."
   input = gets.chomp
   puts "Hello, #{input}. You are signed-in!"
   @user = Guest.create(username: input)
end 

# def name
#    puts "What is your name?"
#    name = gets.chomp
#    puts "Welcome #{name}!"
#    user = Guest.create(username: name)
#    user_id = Booking.create(guest_id: user.id)
#   end

  def options
   prompt = TTY::Prompt.new
    test = prompt.select("Please choose one of the following:") do |book|
   #   book.enum '.' #The use of enums brings the advantage of type safety by assigning the numeric variable in a program with meaningful enum values. Enum is also called enumeration or an enumerator list.
# binding.pry
     book.choice 'Book a Room!', 1
     book.choice 'Update Booking', 2
     book.choice 'See Account Information', 3
     book.choice 'Delete Booking', 4
     book.choice 'Exit', 5
    end 
   #  binding.pry
     if test == 1
         option_1
     elsif test == 2
         option_2
     elsif test == 3
         display_account_info
     elsif test == 4
      delete
     elsif test == 5
       ex
  end 
end 
 
def option_1
   # puts "What is your name?"
   # name = gets.chomp
   # puts "Welcome #{name}!"
   # user = Guest.create(username: name)
   # binding.pry
   system "clear"
   # find_and_update_booking
   prompt = TTY::Prompt.new
   prompt.ask("Please type in a checkin date in the following format on the next line: (yyyy/mm/dd)")
   date1 = gets.chomp
   puts "Ok, your checkin date is #{date1.to_date}!".colorize(:magenta)
   checkin = "#{date1.to_date}"

   # booking.checkin_date = "#{date1.to_date}"
   # binding.pry
   # booking.checkin_date= Booking.update(checkin_date: date1.to_date)
   # Booking.all.find_by(guest_id: Guest.find_by(name: name).id)

   prompt.ask("Please type in a checkout date in the following format: (yyyy/mm/dd)")
   date2 = gets.chomp
   checkout = date2.to_date
   puts "Ok, your checkout date is #{date2.to_date}!".colorize(:magenta)
   test = prompt.select("Please choose from the following available rooms:") do |room|
 
   room.choice "#{Room.first.room_type}", 1
   room.choice "#{Room.all[1].room_type}", 2
   room.choice "#{Room.all[2].room_type}", 3
   room.choice "#{Room.last.room_type}", 4
   end
   # new_user = Booking.create(checkin_date: checkin, checkout_date: checkout, guest_id: user.id)
# binding.pry
   temp = 0
   system "clear"
   if test == 1
      puts "You have picked #{selected_room_one}. You are booked from #{checkin} until #{checkout}!".colorize(:cyan)
      temp = Room.first.id
      # new_user.room_id = Room.first.id
      # binding.pry
   elsif test == 2
      puts "You have picked #{selected_room_two}. You are booked from #{checkin} until #{checkout}!".colorize(:cyan)
      temp = Room.all[1].id
      # booking.room_id = Room.all[1].id
      # new_user.room_id = Room.all[1].id
      # binding.pry
   elsif test == 3
      puts "You have picked #{selected_room_three}. You are booked from #{checkin} until #{checkout}!".colorize(:cyan)
      temp = Room.all[2].id
      # booking.room_id = Room.all[2].id
      # new_user.room_id = Room.all[2].id
   else test == 4
      puts "You have picked #{selected_room_four}. You are booked from #{checkin} until #{checkout}!".colorize(:cyan)
      temp = Room.last.id
      # booking.room_id = Room.last.id
      # new_user.room_id = Room.last.id
      #binding.pry
   end 
   # new_user = Booking.create(checkin_date: checkin, checkout_date: checkout, guest_id: @user.id, room_id: temp)
   @user.bookings << Booking.new_booking(checkin, checkout, @user, temp)
   # binding.pry
   options
end 

def selected_room_one
   Room.first.room_type.colorize(:pink)
   # binding.pry
end

def selected_room_two
   Room.all[1].room_type.colorize(:pink)
end

def selected_room_three
   Room.all[2].room_type.colorize(:pink)
end

def selected_room_four
   Room.last.room_type.colorize(:pink)
end

def option_2
   update_booking
   # system "clear"
   # # Room.display_users_bookings
   #    selected = select_room 
   #    prompt = TTY::Prompt.new
   #   test =  prompt.select("Please choose one of the following to update:") do |update|
   #       # update.enum '.' #The use of enums brings the advantage of type safety by assigning the numeric variable in a program with meaningful enum values. Enum is also called enumeration or an enumerator list.
   #      update.choice 'Change Room', 1
   #      update.choice 'Cancel Reservation', 2
   #   end 
   #   if test == 1
   #    update_booking
   #   end 
   end   #  options
# end

# def select_room
#    user_bookings = @user.bookings
#    binding.pry
#    puts "Currently booked: #{user_bookings}"
#    prompt = TTY::Prompt.new
#    prompt.select("Bookings:", %w(user_bookings))
#      # update.enum '.' #The use of enums brings the advantage of type safety by assigning the numeric variable in a program with meaningful enum values. Enum is also called enumeration or an enumerator list.
#    end 

def update_booking
   puts "Please enter your sign-in name:"
   input = gets.chomp
   search = Guest.find_by(username: input)
   # find_booking = Booking.find_by(guest_id: Guest.find_by(username: input).id)
   # find_booking.update(room_id: 63)
   puts "Let's change your booking, #{input}"
     result = search.rooms.each do |room|
        puts "Here is your booking: #{room.room_type}!".colorize(:yellow)
         end 
   user_bookings = @user.bookings
      prompt = TTY::Prompt.new
      test = prompt.select("Please choose a new room:") do |update|
         binding.pry
         # update.enum '.' #The use of enums brings the advantage of type safety by assigning the numeric variable in a program with meaningful enum values. Enum is also called enumeration or an enumerator list.
         update.choice "#{Room.first.room_type}", 1
         update.choice "#{Room.all[1].room_type}", 2
         update.choice "#{Room.all[2].room_type}", 3
         update.choice "#{Room.last.room_type}", 4
     end  #  options
     if test == 1
      puts "You have picked #{selected_room_one}!".colorize(:magenta)
      temp = Room.first.id
   elsif test == 2
      puts "You have picked #{selected_room_two}!".colorize(:magenta)
      temp = Room.all[1].id
   elsif test == 3
      puts "You have picked #{selected_room_three}!".colorize(:magenta)
      temp = Room.all[2].id
   else test == 4
      puts "You have picked #{selected_room_four}!".colorize(:magenta)
      temp = Room.last.id
   end 
   #   binding.pry
     user_bookings.update(room_id: temp)
end

def display_account_info
   puts "please enter your signin name"
   input = gets.chomp
   search = Guest.find_by(username: input)
   binding.pry
   puts search.bookings

end 



def delete
   system "clear"
   puts "Please enter your sign-in name:"
   input = gets.chomp
   search = Guest.find_by(username: input)
   # find_booking = Booking.find_by(guest_id: Guest.find_by(username: input).id)
   # find_booking.update(room_id: 63)
   puts "Let's delete your booking, #{input}"
     result = search.rooms.each do |room|
        puts "Here is your booking: #{room.room_type}!".colorize(:orange)
         end 
   user_bookings = @user.bookings
   user_bookings.destroy
    puts "You have deleted your booking!".colorize(:cyan)
   end 

def ex
system "clear"
puts "thank you for using my booking!".colorize(:cyan)
system("^C")
end 

# def bookings
#    @user.rooms.map do |room|
#       binding.pry
#       #{room.room_type}"
# end 

#    def see_bookings
#       system "clear"
#       if user.rooms.count == 0
#         puts "You have no bookings!".colorize(:red)
#       else
#         puts "Bookings:".colorize(:cyan)
#       end
#       puts bookings(user)
#       options
#     end
#    end 

# Room.booking.guest


# Booking.find_by(guest_id: Guest.id)


# def find_and_update_booking
# room_id_num = Booking.last.room_id
# booking_id = Booking.last.id
# guest_id = Booking.all.find_by(guest_id: Guest.last).id
# if guest_id == booking_id
#   room_name = Room.all.find_by(id: room_id_num).room_type
#    puts room_name
# end 
# end 


# end 




