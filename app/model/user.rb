class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals

    def retrieve_recipe(keyword)
        Recipe.all.select do |recipe|
            #binding.pry
            recipe.title.include?("keyword")  
                #binding.pry      
        end
    end
end