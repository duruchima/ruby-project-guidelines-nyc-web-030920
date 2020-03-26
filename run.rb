require 'bundler'
Bundler.require


ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
require_all 'app'
@prompt = TTY::Prompt.new

ActiveRecord::Base.logger.level = 1

#sends user back to main_menu method
def back_to_main_menu
    answer = @prompt.yes?('Would you like to do something else?')
    if answer == true
        main_menu()
    elsif answer == false
        puts "Thanks for searching! See you next time #{@name}"
        exit
    end
end

def make_into_meal(recipe)
    answer = @prompt.yes?('Would you like to make a meal out of this recipe?')
    if answer == true
        Meal.create(recipe_id: recipe.id, user_id: @user.id)
        print TTY::Box.frame("We added #{recipe.title} to your meals #{@name}.")
    elsif answer == false

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
            print TTY::Box.frame("What ingredient", "would you like to search for?")
            ingredient_input = gets.chomp.downcase

        #search DB for all matching recipes
        found_it = Ingredient.find_by(name: ingredient_input)
            @results = found_it.recipes

            #if app doesn't find any matching ingredients start over
                if @results == []
                    print TTY::Box.frame("We didn't find anything in the database", "for #{@ingredient_input}.")
                    puts "Please try again"
                    back_to_main_menu

            #if we find the ingredient return all recipe titles containing that ingredient
                else
                    print TTY::Box.frame("Enter the number of the recipe you'd like.")
                    recipe_title = @prompt.enum_select("", @results)
                    recipe = Recipe.find_by(title: recipe_title)
                    print TTY::Box.frame("Okay..Here's the ingredients for #{recipe_title}!")
                    print TTY::Box.frame("#{recipe.ingredients.join(', ')}")
                    make_into_meal(recipe)
                    back_to_main_menu
                end

    #if choice is keyword        
        elsif @input == 'Keyword'
            puts 'What keyword would you like to search for?'   
            keyword_input = gets.chomp.downcase

        #search DB for all matching recipes
            @results = @user.retrieve_recipe(keyword_input)

            #if app doesn't find any matching keywords start over
                if @results == []
                    puts "We didn't find anything in the database for #{keyword_input}."
                    puts "Please try again"
                    back_to_main_menu
            #if we find a keyword return all recipe titles containing that keyword
                else
                    recipe_title = @prompt.enum_select("Enter the number of the recipe you'd like.", @results)
                    recipe = Recipe.find_by(title: recipe_title)
                    print TTY::Box.frame("Okay..Here's the ingredients for #{recipe_title}!")
                    print TTY::Box.frame("#{recipe.ingredients.join(', ')}")
                    make_into_meal(recipe)
                    answer = @prompt.yes?("Would you like more information about this recipe?")
                    if answer == true 
                        puts "For more information about #{recipe.title} please go to: 
                        #{recipe.url}"
                        back_to_main_menu
                    else answer == false 
                        back_to_main_menu
                    end
                        
                end

    #gives user a random method from the database
        elsif @input == 'Give me a random recipe'
                recipe = Recipe.random
                recipe_title = recipe.title
                print TTY::Box.frame("Okay..Here's the ingredients for #{recipe_title}!")
                print TTY::Box.frame("#{recipe.ingredients.join(', ')}")
                make_into_meal(recipe)
                answer = @prompt.yes?("Would you like more information about this recipe?")
                    if answer == true 
                        puts "For more information about #{recipe.title} please go to: 
                        #{recipe.url}"
                        back_to_main_menu
                    else answer == false 
                        back_to_main_menu
                    end
                
    #shows user the recipe that has been made the most times
        elsif @input == 'Show me the most popular recipe'


    #shows user all recipes they have made into meals
        elsif @input == 'Show me my meals'
          print TTY::Box.frame("You've eaten these recipes: #{@user.meals_with_name.join(', ')}.")
          back_to_main_menu

    #exits the app
        elsif @input == 'Exit'
            print TTY::Box.frame("Thanks for searching! See you next time #{@name}")
            exit
        end
end       

#Welcomes the user to the app then sends them to main_menu method
print TTY::Box.frame("Welcome to", "the recipe database!")
@name = @prompt.ask('What is your name?')
       if User.find_by(name: @name)
            print TTY::Box.frame("Welcome back, #{@name}!!")
            @user = User.find_by(name: @name)
            main_menu()
       else
            print TTY::Box.frame("Hi #{@name}, let's get started!")
            @user = User.create(name: @name) 
            main_menu()
        end