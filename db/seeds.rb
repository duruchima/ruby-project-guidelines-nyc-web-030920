require 'pry'
require 'rest-client'
require 'json'
require 'net/http'

Recipe.destroy_all
User.destroy_all
Ingredient.destroy_all
Meal.destroy_all
RecipeIngredient.destroy_all

response = RestClient.get("http://www.recipepuppy.com/api/")
data = JSON.parse(response)
recipes_list = data["results"]

response2 = RestClient.get("http://www.recipepuppy.com/api/?p=45")
data2 = JSON.parse(response2)
recipes_list2 = data2["results"]


u1 = User.create(name: "Tashawn")
u2 = User.create(name: "Alex")
u3 = User.create(name: "Ethan")



#all_ingredients = ingredient_array.flatten.uniq
#stripped_ingredients = all_ingredients.map{|ing| ing.strip}.uniq

recipes_list.each do |recipe_hash|
    recipe = Recipe.create(title: recipe_hash["title"], url: recipe_hash["href"])
    ingredientsarray = recipe_hash["ingredients"].split(",")
    all_ingredients = ingredientsarray.flatten.uniq
    stripped_ingredients = all_ingredients.map{|ing| ing.strip}.uniq

    stripped_ingredients.each do |ingredient_name|
        ingredient = Ingredient.find_or_create_by(name: ingredient_name)
        RecipeIngredient.create(recipes_id: recipe.id, ingredients_id: ingredient.id)
    end
    
end

recipes_list2.each do |recipe_hash|
    recipe = Recipe.create(title: recipe_hash["title"], url: recipe_hash["href"])
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

lunch = Meal.create(user_id: u1.id, recipe_id: Recipe.all.sample.id)
breakfast = Meal.create(user_id: u2.id, recipe_id: Recipe.all.sample.id)
dinner = Meal.create(user_id: u3.id, recipe_id: Recipe.all.sample.id)
    #array = data["results"]
    #ingredient_array = []
    #array.collect do |hash|
        
       # hash.each do |k, v| if k == "ingredients"
      #      ingredient_array << v.split(',')
     #   end
    #end
    #end
    #all_ingredients = ingredient_array.flatten.uniq
    #stripped_ingredients = all_ingredients.map{|ing| ing.strip}.uniq
    #stripped_ingredients.map do |element|
   #binding.pry
    #Ingredient.create(name: element)



"string"