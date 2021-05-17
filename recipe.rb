class Recipe
  attr_reader :name, :description, :rating, :done, :prep_time

  def initialize(name, description, rating, prep_time)
    @name = name
    @description = description
    @rating = rating
    @done = false
    @prep_time = prep_time
  end

  def mark_as_done!
    @done = true
  end

  def done?
    @done
  end
end
