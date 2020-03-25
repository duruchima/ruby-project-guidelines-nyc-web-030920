class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals
    has_many :ingredient_recipes
    has_many :ingredients, through: :ingredient_recipes

    # def self.by_ingredient(ingredient)
    #     self.all.select do |recipe|
    #         recipe.seperate
    #     end
    # end
def ingredients 
    array = RecipeIngredient.all.select {|recipe_ingredients| recipe_ingredients.recipes_id == self.id}
    #array.map {|ingredient_obj| Ingredient.all.select {|ingredient|ingredient.id == ingredient_obj.ingredients_id}}
    new_array = array.map{|ingredient| ingredient.ingredients_id}
    #Ingredient.find() {|ingredient|ingredient.id == new_array.map {|ingredient_obj|ingredient_obj.ingredients_id}}
    #Recipe.joins(:ingredients).where(ingredients: { id: new_array })
    #filtered_meals = Ingredient.includes(:ingredients).where("ingredients.id" => new_array)
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

    # def self.find_ingredient(ingredient)
    #     objects = self.all.select do |recipe|
    #         recipe.has_ingredient(ingredient)
    #     end
    #     objects
    # end

    def popularity #shows the number of times a recipe has been made (into a meal)
        array = []
        Meal.all.select do |meal|
            if meal.recipe == self
                array << meal
            end
        end
        puts "#{self.title} has been made #{array.length} times!"
    end

    def self.random #returns a random recipe from the DB for the user
        Recipe.all.sample
    end

end