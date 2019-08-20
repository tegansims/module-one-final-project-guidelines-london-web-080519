require "tty-prompt"

class CLI 

    @prompt = TTY::Prompt.new

    @current_user = nil 

    def self.greet 
       puts "Welcome to Kindr!"
    end 


    def self.check_if_have_login_and_create
        check = @prompt.yes?("Do you have a username?")
        if check 
            self.account_login 
        else 
            self.create_new_username
        end 
    end  

    def self.account_login #NEED TO PUT A COUNTER IN HERE TO STOP THE LOOP IF FORGOTTEN
        user_username = @prompt.ask("Enter username")
        user_password = @prompt.mask("Enter password")
        user = User.find_by(username: user_username, password: user_password)
        if !user 
            puts "Not a valid login. Please try again"
            self.account_login 
        else 
            puts "Welcome back #{user.name}! Time to find your baby's name!"
        end 
        @current_user = user 
    end 

    def self.create_new_username 
        username_input = @prompt.ask("Please create a username")
        user = User.find_by(username: username_input)
        if !user 
            user_name = @prompt.ask("What is your name?")
            user_password = @prompt.mask("Create a password")
        new_user = User.create(username: username_input, name: user_name, password: user_password )
        @current_user = new_user
        end 
    end 

  
     
     def self.upload_own_name
        puts "TO BUILD: give us your choice of name"
        puts "TO BUILD: is this a pick or a reject?"
     end
     
     def self.home_menu
        options = [
            {"Random name" => -> do get_random_name end},
            {"Show my matches" => -> do show_matches end},
            {"Upload own name" => -> do upload_own_name end},
            {"Show my Picks" => -> do show_picks end},
            {"Show my Rejects" => -> do show_rejects end},
            {"Log Out" => -> do log_out end},
            {"Delete account" => -> do delete_account end},
        ]
        @prompt.select("here are your options:", options)
     end
#  #------------- SHOW NAMES ---------------------- 
#  def self.show_picks(yn)
#     Pick.where(user_id: @current_user.id, yes_or_no: yn)
#  end
 
#  def self.show_rejects
#     puts "TO BUILD: here are all your rejects"
#  end

#  def self.show_matches
#     puts "TO BUILD: What's your partner username?"
#     puts "TO BUILD: here are all your matches"
#  end

 #------------- RANDOM NAME ---------------------- 

    #   #choose gender.  
    # def choose_gender
    #     menu_choice = @prompt.select('Would you like to choose choose gender?', filter:true) do |menu|
    #         menu.choice name: 'Female', value: 1
    #         menu.choice name: 'Male', value: 2
    #         menu.choice name: "I don't want to choose by gender", value 3 
    #     end 
    # end  

    def self.get_random_name 
        Name.all.sample
    end 

    def self.random_name_all 
        random_name = get_random_name 
        if Pick.find_by(user_id: @current_user.id, name_id: random_name.id)
            self.random_name_all
            puts "re-running"     
        else 
            puts "your name is #{random_name.name}"
        end 
    end 



    # def random_name_gender(gender)

    # end 

    # #choose name and put in pick folder as yes
    # def pick_name_yes(user_id, name_id, comment, rating, yes_or_no = "yes")
    #     Pick.create(user_id, name_id, comment, rating)
    # end 

    # def pick_name_no(user_id, name_id, comment, rating, yes_or_no = "no")
    #     Pick.create(user_id, name_id, comment, rating)
    # end 


    # method to ask user if they want to continue choosing 
    # if yes, call random_name_gender again 
    # if no take them back to main menu 


#---------------------------DELETE ACCOUNT HERE---------------------------------------------
    def self.destroy_account
        puts "TO BUILD: this is where we delete it"
        user_delete_picks = Pick.where(user_id: @current_user.id)
        user_delete_picks.destroy_all
        User.destroy(@current_user.id)
    end

    def self.delete_account
        options = [
            {"Yes, please delete my account" => -> do destroy_account end},
            {"No, please take me back to the menu!" => -> do self.home_menu end}
        ]
        @prompt.select("Are you sure? This will erase all your account info and history.", options)
    end

#---------------------------LOG_OUT METHOD HERE---------------------------------------------

    def self.log_out
        puts "Thank you for using Kindr! See you again soon."
        @current_user = nil
    end
#---------------------------RUN METHOD HERE---------------------------------------------

    def self.methods 
        self.greet
        self.check_if_have_login_and_create
        self.home_menu
        # self.random_name_all
        # self.delete_account
    end 


 end