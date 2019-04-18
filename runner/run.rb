require 'colorize'
require 'pry'
# require_relative '../app/models/guest'
require 'date'


def welcome
   art = TTY::Font.new(:starwars) 
   puts art.write("Welcome")   
   puts art.write("To")   
   puts art.write("My Bookings!")   
end 

def signin
   puts "Sign up with your name."
   input = gets.chomp
   puts "Hello, #{input}. You are signed-in!"
   @user = Guest.create(username: input)
end 


def welcome_menu
   prompt = TTY::Prompt.new
    test = prompt.select("Please choose one of the following:") do |book|
   #   book.enum '.' #The use of enums brings the advantage of type safety by assigning the numeric variable in a program with meaningful enum values. Enum is also called enumeration or an enumerator list.
# binding.pry
     book.choice 'Book a Room!', 1
     book.choice 'Exit', 2
    end 
   #  binding.pry
     if test == 1
         checkin_validator
     else 
         exit_method
  end 
end 

  def main_menu
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
         checkin_validator
     elsif test == 2
         option_2
     elsif test == 3
         display_account_info
     elsif test == 4
         delete
     elsif test == 5
         exit_method
  end 
end 

def checkin_validator
   prompt = TTY::Prompt.new
   prompt.ask("Please type in a checkin date in the following format on the next line: (yyyymmdd)")
   date1 = gets.chomp
   checkin = ""
   if date1 =~ /[0-9]/ && date1.size == 8 
      date1 = Date.parse(date1).strftime("%Y%m%d")
      checkin = "#{date1.to_date}"
   puts "Ok, your checkin date is #{date1.to_date}!".colorize(:magenta)
   checkout_validator(checkin)
   else  
      puts "Invalid date format, try again please!"
      sleep 2
      checkin_validator
   end 
end

 def checkout_validator(checkin)
   prompt = TTY::Prompt.new
   prompt.ask("Please type in a checkout date in the following format: (yyyymmdd)")
   date2 = gets.chomp
   checkout = ""
   if date2 =~ /[0-9]/ && date2.size == 8 && Date.parse(date2).strftime("%Y%m%d") != checkin
      date2 = Date.parse(date2).strftime("%Y%m%d")
      checkout = "#{date2.to_date}"
   puts "Ok, your checkout date is #{checkout}!".colorize(:magenta)
      option_1(checkin, checkout)
   else  
      puts "Invalid date format, try again please!"
      sleep 2
      checkout_validator
   end 
 end 

def option_1(checkin, checkout)
   system "clear"
   # checkin_validator
   # checkout_validator
   # find_and_update_booking
   # prompt = TTY::Prompt.new
   # prompt.ask("Please type in a checkin date in the following format on the next line: (yyyymmdd)")
   # date1 = gets.chomp
   # checkin = ""
   # if date1 =~ /[0-9]/ && date1.size == 8 
   #    date1 = Date.parse(date1).strftime("%Y%m%d")
   #    checkin = "#{date1.to_date}"
   # puts "Ok, your checkin date is #{date1.to_date}!".colorize(:magenta)
   # else  
   #    puts "Invalid date format, try again please!"
   #    sleep 3
   #    option_1
   # end 


   # prompt.ask("Please type in a checkout date in the following format: (yyyymmdd)")
   # date2 = gets.chomp
   # checkin = ""
   # if date2 =~ /[0-9]/ && date2.size == 8
   #    date2 = Date.parse(date2).strftime("%Y%m%d")
   #    checkout = "#{date2.to_date}"
   # puts "Ok, your checkin date is #{date2.to_date}!".colorize(:magenta)
   # else  
   #    puts "Invalid date format, try again please!"
   #    sleep 3
   #    option_1
   # end 
   # puts "Ok, your checkout date is #{date2.to_date}!".colorize(:magenta)
   prompt = TTY::Prompt.new
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
   @user.bookings = []
   @user.bookings << Booking.new_booking(checkin, checkout, @user, temp)
   # binding.pry
   main_menu
end 


def selected_room_one
   Room.first.room_type.colorize(:pink)
   # binding.pry
end

def selected_room_two
   Room.second.room_type.colorize(:pink)
end

def selected_room_three
   Room.third.room_type.colorize(:pink)
end

def selected_room_four
   Room.last.room_type.colorize(:pink)
end

def option_2
   update_booking
   end   
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
   # puts "Please enter your sign-in name:"
   # input = gets.chomp
   # search = Guest.find_by(username: input)
   # find_booking = Booking.find_by(guest_id: Guest.find_by(username: input).id)
   # find_booking.update(room_id: 63)
   # puts "Let's change your booking, #{input}"
      @user.rooms.each do |room|
        puts "Here is your booking: #{room.room_type}!".colorize(:yellow)
         end 
   user_bookings = @user.bookings
      prompt = TTY::Prompt.new
      test = prompt.select("Please choose a new room:") do |update|
         # binding.pry
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
     main_menu
end

def booking
   a = Booking.all.find_by(guest_id: @user.id)
      a.room.room_type
      # binding.pry
   end 

def display_account_info
   # puts Room.display_names
   system "clear"
   if @user.bookings.count == 0
      puts "You have no bookings!"
   else
      puts "Bookings:"
   end 
puts booking
main_menu
# binding.pry  
end

def delete
   system "clear"
   # result = Guest.all.find( @user.id)
      # result.each do |room|
      # puts "Here is your booking: #{room.room_type}!".colorize(:orange)
      # end
      # a = Guest.all.find(@user.id)
      Booking.delete(Booking.last.id)
      # a.destroy
    puts "You have deleted your booking!".colorize(:cyan)
      # binding.pry
      welcome_menu
end

   def exit_method
      system "clear"
      puts "Thank you for using my booking!".colorize(:cyan)
      exit
   end 

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




