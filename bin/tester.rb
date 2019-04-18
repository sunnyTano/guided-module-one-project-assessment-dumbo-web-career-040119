require 'colorize'
require 'pry'
require 'date'

def welcome
   system "clear"
   art = TTY::Font.new(:starwars) 
   # puts art.write("Welcome")   
   # puts art.write("To")   
   puts art.write("My Bookings!")   
   sleep 1
   sign_or_log
end 

def sign_or_log
   prompt = TTY::Prompt.new
   test = prompt.select("Sign-up or Login!") do |book|
   # book.enum '.' #The use of enums brings the advantage of type safety by assigning the numeric variable in a program with meaningful enum values. Enum is also called enumeration or an enumerator list.
   # binding.pry
    book.choice 'Sign-up', 1
    book.choice 'Login', 2
   end 
    if test == 1
        signup
    else 
        login
 end 
end 

def signup
   puts "Sign up with your name."
   input = gets.chomp
   puts "Hello, #{input}. You are signed-in!"
   @user = Guest.create(username: input)
   sleep 1
   welcome_menu
end 

def login
   puts "Enter your username"
   input = gets.chomp
   @user = Guest.find_by(username: input)
   if @user == input
      puts "Hello, #{input}. You are signed-in!"
      welcome_menu
   else
      prompt = TTY::Prompt.new
      test = prompt.select("It doesn't look like you are in the system. Would you like to retry loggin in or sign up?".colorize(:yellow)) do |book|
       sleep 1
       book.choice 'Retry loggin in', 1
       book.choice 'Signup', 2
      end 
      if test == 1
         login
     else 
         signup
      end 
   end
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
    arr = 
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
      checkout_validator(checkin)
   end 
 end 

def option_1(checkin, checkout)
   system "clear"
   prompt = TTY::Prompt.new
   # Room.display_names
   test = prompt.select("Please choose from the following available rooms:") do |room|
 
   room.choice "#{Room.first.room_type}", 1
   room.choice "#{Room.second.room_type}", 2
   room.choice "#{Room.third.room_type}", 3
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
      temp = Room.second.id
      # booking.room_id = Room.all[1].id
      # new_user.room_id = Room.all[1].id
      # binding.pry
   elsif test == 3
      puts "You have picked #{selected_room_three}. You are booked from #{checkin} until #{checkout}!".colorize(:cyan)
      temp = Room.third.id
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

def update_booking
      @user.rooms.each do |room|
        puts "Here is your booking: #{room.room_type}!".colorize(:yellow)
         end 
   user_bookings = @user.bookings
      prompt = TTY::Prompt.new
      test = prompt.select("Please choose a new room:") do |update|
         # binding.pry
         # update.enum '.' #The use of enums brings the advantage of type safety by assigning the numeric variable in a program with meaningful enum values. Enum is also called enumeration or an enumerator list.
         update.choice "#{Room.first.room_type}", 1
         update.choice "#{Room.second.room_type}", 2
         update.choice "#{Room.third.room_type}", 3
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

def view_booking
   a = Booking.all.find_by(guest_id: @user.id)
      "YOU ARE BOOKED IN: #{a.room.room_type}. CHECKIN DATE: #{a.checkin_date} CHECKOUT DATE: #{a.checkout_date}".colorize(:magenta)
   #single source of truth {a.room.room_type}
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
puts view_booking
main_menu
# binding.pry  
end

def delete
   system "clear"
      Booking.delete(Booking.last.id)
    puts "You have deleted your booking!".colorize(:cyan)
      # binding.pry
      welcome_menu
end

   def exit_method
      system "clear"
      art = TTY::Font.new(:starwars) 
      puts art.write("Thank You")   
      puts art.write("For Using")   
      puts art.write("My Bookings!")   
      exit
   end



