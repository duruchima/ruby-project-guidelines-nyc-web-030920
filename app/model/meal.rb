class Meal < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe
    
    def self.random #returns a random recipe from the DB for the user
        sample = Meal.all.sample
        sample.user_id
    end

#returns the number of times a recipe has been made into a meal ( helper method )
    def self.meal_quantity
        meal_hash = {}
        Meal.all.map do |meal|
            meal_hash[meal.recipe_id] ? meal_hash[meal.recipe_id] += 1 : meal_hash[meal.recipe_id] = 1
        end
        meal_hash
    end

    def self.most_popular
        most_popular_array = []
        meal_hash = meal_quantity
        meal_hash.each {|k, v| most_popular_array << Recipe.find(k).title if v == meal_hash.values.max}
        most_popular_array.join(', ')
    end


end