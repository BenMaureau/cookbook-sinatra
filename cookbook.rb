require 'csv'

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    CSV.foreach(@csv_file_path) do |row|
      recipe = Recipe.new(row[0], row[1], row[2], row[3])
      @recipes << recipe
    end
  end

  def all
    @recipes
  end

  def find(index)
    @recipes[index]
  end

  def add_recipe(recipe)
    @recipes << recipe
    CSV.open(@csv_file_path, "a") do |csv|
      csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time]
    end
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    # table = CSV.foreach(@csv_file_path) do |row|
    #   row.delete_at(recipe_index)
    table = CSV.table(@csv_file_path)
    table.delete(recipe_index)
    File.open(@csv_file_path, 'wb') do |f|
      f.write(table.to_csv)
    end
  end
end
