class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals
    has_many :ingredient_recipes
    has_many :ingredients, through: :ingredient_recipes

def ingredients 
    array = RecipeIngredient.all.select {|recipe_ingredients| recipe_ingredients.recipes_id == self.id}
    new_array = array.map{|ingredient| ingredient.ingredients_id}
    ingredient_name = []
    ingredients_names = []
    new_array.map do |ingredient_id| ingredient_name << Ingredient.find(ingredient_id) end
    ingredient_name.map {|ingredients| ingredients_names << ingredients.name}
    return ingredients_names
end

    def has_ingredient(ingredient)
    array =  self.ingredients
        if array.include?(ingredient)
            return "This recipe contains #{ingredient}, here is a list of all the ingredients it contains #{self.ingredients}."
        else
            return "This recipe does not contain #{ingredient}"            
        end
    end
     
#shows the number of times a recipe has been made (into a meal)
    def popularity 
        array = []
        Meal.all.select do |meal|
            if meal.recipe == self
                array << meal
            end
        end
        puts "#{self.title} has been made #{array.length} times!"
    end

    def self.meal_quantity
        meal_hash = {}
        Meal.all.map do |meal|
            if meal_hash[:recipe]
                binding.pry
                meal_hash[:recipe] += 1
            else
            meal_hash[:recipe] =  meal.recipe_id
            meal_hash[:recipe][count] = 1
            end
            binding.pry
        end
    end
    
    # def self.most_popular
    #     array = self.all.select do |meal|
    #         binding.pry
    #         meal.to_h{|m| [m, 1]}
    #     end
    # end

#returns a random recipe from the DB for the user  
    def self.random 
        Recipe.all.sample
    end
end
