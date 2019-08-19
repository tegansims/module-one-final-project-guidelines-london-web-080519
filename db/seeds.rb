require_relative "../app/models/name.rb"

# User.create(name: "Angie" , username: "angieshin", password:"abc123")
# User.create(name: "Tegan", username: "tegansims", password: "123456")
# User.create(name: "Oli", username:"oliburt", password:"123abc")
# User.create(name: "George" , username:"georgekirby", password: "654321")


100.times do 
    girl_name = Faker::Name.unique.female_first_name 
    Name.create(name: girl_name, gender: "Female")
    end

100.times do 
    boy_name = Faker::Name.unique.male_first_name 
    Name.create(name: boy_name, gender: "Male")
    end
    