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

    def self.most_popular
        id_array = []
        Meal.all.select do |meal|
            id_array << meal.recipe_id #[89, 77, 88, 89, 89]
        end
        hash = {}
        value = 0
        id_array.map do |e|
            if hash[e]
                hash[e] += 1 
            else
                hash[e] = 1
            end
            value = hash.max_by{|k,v| v}
        end
       value[0]
    end

#returns a random recipe from the DB for the user  
    def self.random 
        Recipe.all.sample
    end
end
