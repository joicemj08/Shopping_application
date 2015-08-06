class AddingProducts < ActiveRecord::Migration
  def change
  	products = [
  		['shoe', 'footwares', '500', '2'],
  		['perfume', 'beauty', '250', '2']
  	]
  	products.each do |pdt|
		  catcode = Category.find_by(code: pdt[1])
      next if catcode.blank?
  		product = Product.new(
        name: pdt[0], category_id: catcode.id, unit_price: pdt[2], quantity: pdt[3])
    	product.save
  	end
  end
end
