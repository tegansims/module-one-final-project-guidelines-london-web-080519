require "tty-prompt"

class Cli 


    def greet 
        "Welcome to Kindr!"
    end 


    def have_login?
        puts "Do you have a username?"
    end  

    def user_create(name, username, password)
        User.create(name, username, password)
    end 

    def get_user_instance(username)
        User.find_by(username: username)
    end 

    def password_valid?(username, password)
        user = get_user_instance(username) 
        user.password == password? 
    end 

    def account_login 
        puts "Enter username"
        user_username = gets.chomp 
        password = TTY::Prompt.new
        user_password = password.mask("Enter password")
        user = User.find_by(username: user_username, password: user_password)
        if !user 
            puts "Not a valid login. Please try again"
            account_login 
        else 
            puts "Welcome back #{user.name}! Time to find your baby's name!"
        end 
        current_user = user 
    end 


end 