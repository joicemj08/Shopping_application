class Product < ActiveRecord::Base
  belongs_to :category

  def self.search(search)
    if search
      self.where("name like ?", "%#{search}%")
    end
  end
end
