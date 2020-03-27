class Ingredient < ActiveRecord::Base
    has_many :ingredient_recipes
    has_many :recipes, through: :ingredient_recipes

    def recipes
        array = RecipeIngredient.all.select {|recipe_ingredients| recipe_ingredients.ingredients_id == self.id}
        new_array = array.map{|recipe| recipe.recipes_id}
        recipe_name = []
        recipes_names = []
        new_array.map  {|recipe_id| recipe_name << Recipe.find(recipe_id)}
        recipe_name.map {|recipes| recipes_names << recipes.title}
        return recipes_names
    end
    
end