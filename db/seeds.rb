require 'pry'
require 'rest-client'
require 'json'
require 'net/http'

Recipe.destroy_all

response = RestClient.get("http://www.recipepuppy.com/api/")
data = JSON.parse(response)
recipes_list = data["results"]



u1 = User.new(name: "Tashawn")
u2 = User.new(name: "Alex")
u3 = User.new(name: "Ethan")


recipes_list.each do |recipe_hash|
    recipe = Recipe.create(title: recipe_hash["title"])
    ingredientsArray = recipe_hash["ingredients"].split(",")
    

    ingredientsArray.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        RecipeIngredient.create(recipes_id: recipe.id, ingredients_id: ingredient.id)
    end
    
end
 

    array = data["results"]
    ingredient_array = []
    array.collect do |hash|
        
        hash.each do |k, v| if k == "ingredients"
            ingredient_array << v.split(',')
        end
    end
    end

    all_ingredients = ingredient_array.flatten.uniq

all_ingredients.map do |element|
   
    Ingredient.create(name: element)
end


"string"