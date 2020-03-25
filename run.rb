require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
prompt = TTY::Prompt.new

ActiveRecord::Base.logger.level = 1

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
        rand_str = 'Give me a random recipe'
    input = prompt.select("How would you like to search for recipes? By..") do |menu|
        menu.choice 'Keyword'
        menu.choice 'Ingredient'
        menu.choice rand_str
    end
        #executing method based on input choice
        #searching by ingredient
        if input == 'ingredient'
            puts "What ingredient would you like to search for?"
        #searching by keyword
        elsif input == 'keyword'
            puts 'What keyword would you like to search for?'   
            keyword_input = gets.chomp.downcase
            
            #search DB for all matching recipes
            @results = user.retrieve_recipe(keyword_input)
            #does user want more information about a recipe
            # yes_no = prompt.yes?("Would you like to check out any of these recipes?") 
            #if they do then get it for them!
            
                recipe_title = prompt.enum_select("Enter the number of the recipe you'd like.", @results)
                recipe = Recipe.find_by(title: recipe_title)
                binding.pry
                puts "Okay..Here's the ingredients for #{recipe_title}!"
                puts "#{recipe.ingredients.join(', ')}"
            
                puts "Send them back to SEARCH"
            elsif input = rand_str
                recipe = Recipe.random
                recipe_title = recipe.title
                puts "Okay..Here's the ingredients for #{recipe_title}!"
                puts "#{recipe.ingredients.join(', ')}"
        
        end
