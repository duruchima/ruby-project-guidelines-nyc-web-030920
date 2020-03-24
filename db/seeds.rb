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

recipes_list.each do |recipe|
    Recipe.create(title: recipe["title"], ingredients: recipe["ingredients"] )
end



"string"