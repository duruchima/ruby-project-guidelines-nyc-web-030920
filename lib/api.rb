require 'net/http'
require 'open-uri'
require 'json'

class GetRecipes
    URL = "http://www.recipepuppy.com/api/"

    def get_recipes(url = URL)
        uri = URI.parse(URL)
        response = Net::HTTP.get_response(uri)
        response.body
        
    end

    def url_helper(query, ingredients)
        uri = URI.parse("http://www.recipepuppy.com/api/?#{query}=#{ingredients}")
        
    end

    def recipe_by_name(name)
        uri = url_helper("q", name)
        response = Net::HTTP.get_response(uri)
        json = response.body
        recipe = JSON.parse(json)
    end

    def get_recipe_by_ingredients(ingredients)
        uri = url_helper("i", ingredients)
        response = Net::HTTP.get_response(uri)
        json = response.body
        recipes = JSON.parse(json)
    end

    def get_recipe_by_category

    end
    
end

recipes = GetRecipes.new.get_recipes
#puts recipes

# recipe1 = GetRecipes.new.recipe_by_name("ham")
# puts recipe1

# recipe2 = GetRecipes.new.get_recipe_by_ingredients("ham, cheese")
#  puts JSON.parse(recipe2)


