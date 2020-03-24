class RecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_ingredients do |t|
      t.integer :ingredients_id
      t.integer :recipes_id
    end
  end
end
