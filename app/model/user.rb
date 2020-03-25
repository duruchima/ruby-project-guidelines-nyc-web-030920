class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals

    def retrieve_recipe(keyword)
        keyword = keyword.downcase
        array = []
        Recipe.all.select do |recipe|
           title =  recipe.title.downcase
                if title.include?(keyword)  
                    array << recipe.title
                end
        end
        array
    end
end