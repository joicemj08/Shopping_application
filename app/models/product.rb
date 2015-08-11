class Product < ActiveRecord::Base
  belongs_to :category
  paginates_per 3
  def self.search(search)
    if search
      self.joins("LEFT JOIN categories ON categories.id = products.category_id")
        .where("categories.name like ? OR products.name like ? " , "#{search}%" , "#{search}%")
    else
      all
    end
  end
end
