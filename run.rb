require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
prompt = TTY::Prompt.new


# introduction
    puts "Welcome to the recipe database!"
     name = prompt.ask('What is your name?')
            if User.find_by(name: name)
                puts "Welcome back, #{name}!!"
                user = User.find_by(name: name)
            else
                puts "Hi #{name}, let's get started!"
                user = User.new(name: name) #make sure you change this to create whn finished developing

        end

#determining user's preferred search method
    input = prompt.select("How would you like to search for recipes? By..", %w(keyword ingredient)
        #executing method based on input choice
        #searching by ingredient
        if input == 'ingredient'
            puts "What ingredient would you like to search for?"
        #searching by keyword
        elsif input == 'keyword'
            puts 'What keyword would you like to search for?'   
            keyword_input = gets.chomp.downcase
            
            #search DB for all matching recipes
            puts "here's what we found for #{keyword_input}"
            results = user.retrieve_recipe(keyword_input)
            puts results
            
            #does user want more information about a recipe
            yes_no = prompt.yes?("Would you like to check out any of these recipes?") 
            #if they do then get it for them!
            if yes_no == 'y'
                prompt.select("Enter the number of the recipe you'd like.")
                num_of_input = gets.chomp.to_i
                index_of_array = num_of_input - 1
                recipe_title = results[index_of_array][3..-1]
                recipe = Recipe.find_by(title: recipe_title)
                # recipe_ingre = recipe.ingredients
                puts "Okay..Here's the ingredients for #{results[index_of_array]}!"
                puts "NEED recipe.ingredients to list all ingredients for that recipe!!"
            elsif yes_no == 'n'
                puts "Send them back to SEARCH"
            end
            
        end

puts ' get out of here freeloader'


def help_menu
    puts "Try entering one of the following commands."
    puts "ingredient => to search database for a particular ingredient"

end