class CreateUsers < ActiveRecord::Migration[4.2]
    def change 
        create_table :users do |t| 
        t.string :name
        t.string :username 
        t.string :password 
        end 
    end 
end 
