class Guest < ActiveRecord::Base
    has_many :bookings
    has_many :rooms, through: :bookings

# def self.signup
#    puts "Sign up with your name."
#    input = gets.chomp
# #    if input == Guest.find_by(username: input)
#    puts "Hello, #{input}. You are signed-in!"
#    @user = Guest.create(username: input)
#    sleep 1
# #    welcome_menu
#     end 

# def self.get_first_room
#     self.rooms.first 
#     binding.pry
# end 
#instance methods can only be use within the current instance in the Guest class then 

# @@ll = []

# def self.all
#     @@all
# end 



end 

