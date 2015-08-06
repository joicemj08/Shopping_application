class AddingCategories < ActiveRecord::Migration
  def change
  	 categories = [
      ['Footwares', 'footwares'], ['Beauty', 'beauty']
    ] 

    categories.each do |cat|
      category = Category.new(name: cat[0], code: cat[1])
      category.save
    end
  end
end
