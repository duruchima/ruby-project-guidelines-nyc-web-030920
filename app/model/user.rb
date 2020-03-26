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

    def meals_with_name
        array = Meal.all.select {|meals| meals.user_id == self.id}
        new_array = array.map{|recipe| recipe.recipe_id}
        recipe_name = []
        recipes_names = []
        new_array.map do |recipe_id| recipe_name << Recipe.find(recipe_id) end
        recipe_name.map {|recipes| recipes_names << recipes.title}
        return recipes_names
    end
    

end