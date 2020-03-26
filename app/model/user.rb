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
                    array << "#{recipe.title}"
                    
                end
        end
        array
    end

    def meals_with_name
        recipe_object = []
        recipes_names = []
        meal_array = Meal.all.select {|meals| meals.user_id == self.id}
        recipe_id_array = meal_array.map{|recipe| recipe.recipe_id}
        recipe_id_array.map {|recipe_id| recipe_object << Recipe.find(recipe_id)}
        recipe_object.map {|recipes| recipes_names << recipes.title}
        return recipes_names
    end
    
end