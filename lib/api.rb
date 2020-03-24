#require 'net/http'
#require 'open-uri'
#require 'json'


class GetRecipes
    URL = "http://www.recipepuppy.com/api/"

    def get_recipes
        uri = URI(URL)
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end

    def url_helper(search_type, ingredient)
        url = "http://www.recipepuppy.com/api/?#{search_type}=#{ingredient}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end

    def get_recipe_by_ingredient(ingredient)
        parsed_response = url_helper("i", ingredient)
    end


    def get_recipe_by_name(name)
        parsed_response = url_helper("q", name)
        array = parsed_response["results"]
        new_array = []
        array.collect do |hash|
            hash.each do |k, v| if k == "title"
                new_array << v
            end
        end
        end

        new_array
    end

    
end

recipes = GetRecipes.new.get_recipe_by_name("sandwich")
puts recipes
binding.pry

# recipe1 = GetRecipes.new.recipe_by_name("ham")
# puts recipe1

# recipe2 = GetRecipes.new.get_recipe_by_ingredients("ham, cheese")
#  puts JSON.parse(recipe2)


