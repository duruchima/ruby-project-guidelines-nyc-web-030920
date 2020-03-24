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
    IngredientRecipe.all.select == self
end

    # def has_ingredient(ingredient)
    #     if self.ingredients 
    #         ingredients =  self.ingredients
           
    #         array = ingredients.split(',')
    #         array.find do |element|
    #             element == ingredient
    #         end
    #         return selff
    #     else
    #         put "it doesn't have that"
    #     end
    # end

    # def self.find_ingredient(ingredient)
    #     objects = self.all.select do |recipe|
    #         recipe.has_ingredient(ingredient)
    #     end
    #     objects
    # end



end