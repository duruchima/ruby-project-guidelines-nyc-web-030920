class Meal < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe

   # def get_user_name
    #    self.user_id.name
    #end
end