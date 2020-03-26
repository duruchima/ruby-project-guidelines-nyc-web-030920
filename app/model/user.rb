class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals

    def retrieve_recipe(keyword)
        keyword = keyword.downcase
        array = []
        i = 0
        Recipe.all.select do |recipe|
           title =  recipe.title.downcase
                if title.include?(keyword)  
                    array << "#{i+1}. #{recipe.title}"
                    i += 1
                end
        end
        array
        
    end
    #

end