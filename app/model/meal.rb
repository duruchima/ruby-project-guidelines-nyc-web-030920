class Meal < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe

    def self.random #returns a random recipe from the DB for the user
        sample = Meal.all.sample
        sample.user_id
    end
end