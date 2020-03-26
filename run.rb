require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
@prompt = TTY::Prompt.new
ActiveRecord::Base.logger.level = 1

def back_to_main_menu
    answer = @prompt.yes?('Would you like to do something else?')
    if answer == true
        main_menu()
    elsif answer == false
        puts "Thanks for searching! See you next time #{@name}"
        exit
    end
end

#prompt for search choice
def main_menu
    @input = @prompt.select("How would you like to search for recipes? By..") do |menu|
        menu.choice 'Keyword'
        menu.choice 'Ingredient'
        menu.choice 'Give me a random recipe'
        menu.choice 'Show me the most popular recipe'
        menu.choice 'Show me my meals'
        menu.choice 'Exit'
    end    
     #if choice is ingredient
        if @input == 'Ingredient'
            puts "What ingredient would you like to search for?" 
            @ingredient_input = gets.chomp.downcase
        #search DB for all matching recipes
        found_it = Ingredient.find_by(name: @ingredient_input)
            @results = found_it.recipes
                if @results == []
                    puts "We didn't find anything in the database for #{@ingredient_input}."
                    puts "Please try again"
                    back_to_main_menu
                else
                    recipe_title = @prompt.enum_select("Enter the number of the recipe you'd like.", @results)
                    recipe = Recipe.find_by(title: recipe_title)
                    puts "Okay..Here's the ingredients for #{recipe_title}!"
                    puts "#{recipe.ingredients.join(', ')}"
                    back_to_main_menu
                    
                end
        elsif @input == 'Keyword'
            puts 'What keyword would you like to search for?'   
            keyword_input = gets.chomp.downcase
        #search DB for all matching recipes
            @results = @user.retrieve_recipe(keyword_input)
                if @results == []
                    puts "We didn't find anything in the database for #{keyword_input}."
                    puts "Please try again"
                    back_to_main_menu
                else
                    recipe_title = @prompt.enum_select("Enter the number of the recipe you'd like.", @results)
                    recipe = Recipe.find_by(title: recipe_title)
                    puts "Okay..Here's the ingredients for #{recipe_title}!"
                    puts "#{recipe.ingredients.join(', ')}"
                    answer = @prompt.yes?("Would you like more information about this recipe?")
                    if answer == true 
                        puts "For more information about #{recipe.title} please go to: 
                        #{recipe.url}."
                        back_to_main_menu
                    else answer == false 
                    back_to_main_menu
                    end
                        
                end
        elsif @input == 'Give me a random recipe'
                recipe = Recipe.random
                recipe_title = recipe.title
                puts "Okay..Here's the ingredients for #{recipe_title}!"
                puts "#{recipe.ingredients.join(', ')}"
                back_to_main_menu
        elsif @input == 'Show me the most popular recipe'

        elsif @input == 'Show me my meals'
          puts "You've eaten these recipes: #{@user.meals_with_name.join(', ')}."
          back_to_main_menu
        elsif @input == 'Exit'
            puts "Thanks for searching! See you next time #{@name}"
            exit
        else 
            puts "We didn't find anything in the database for that input."
            puts "Please try again"
            back_to_main_menu()
        end
end       

#Welcomes the user to the app
puts "Welcome to the recipe database!"
@name = @prompt.ask('What is your name?')
       if User.find_by(name: @name)
           puts "Welcome back, #{@name}!!"
           @user = User.find_by(name: @name)
           main_menu()
       else
           puts "Hi #{@name}, let's get started!"
           @user = User.create(name: @name) #make sure you change this to create when finished developing
           main_menu()
        end