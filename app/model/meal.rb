class Meal < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe

   # def get_user_name
    #    self.user_id.name
    #end

<<<<<<< HEAD
    
=======
    def self.random #returns a random recipe from the DB for the user
        sample = Meal.all.sample
        sample.user_id
    end
>>>>>>> a96939772187ecd6fb95411428d8bf438353ec56
end