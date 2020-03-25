require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'

puts "Welcome to the recipe database!"
# introduction
    puts "What is your name?"
        name = gets.chomp.capitalize
    puts "Hi #{name}, let's get started!"

user = User.new(name: name) #make sure you change this to create

#determining user's preferred search method
    puts "How would you like to search for recipes?"
    puts "By keyword? or by ingredient?"
        input = gets.chomp.downcase

#executing method based on input choice
    if input == 'ingredient'
    puts "What ingredient would you like to search for?"
    end

#searching by keyword
    elsif input == 'keyword'
    puts 'What keyword would you like to search for?'   
    keyword_input = gets.chomp.downcase
    #search DB for all matching recipes
    results = user.retrieve_recipe(keyword_input)
    puts "here's what we found for #{keyword_input}"
    puts results

#does user want more information about a recipe
    puts "would you like to check out any of these recipes?"
    yes_no = gets.chomp.downcase
        if yes_no = 'yes' || 'y'
        puts "Which recipe would you like more information about?"




elsif input == 'help'
puts "LETS PUT A HELP MENU HERE SO PEOPLE KNOW WHAT THEY CAN DO"
else
put "try entering 'ingredient' or 'name'"

end

puts ' get out of here freeloader'


def help_menu
    puts "Try entering one of the following commands."
    puts "ingredient => to search database for a particular ingredient"
    
end