class Product < ActiveRecord::Base
  belongs_to :category
  has_many :offers
  paginates_per 3
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/noimage.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  def self.search(search)
    if search
      #self.joins(:category)
        #.where("categories.name like ? OR products.name like ? " , "#{search}%" , "#{search}%")
         where("name like ?", "#{search}%")
    else
      all
    end
  end
  def avatar_url
    avatar.url(:thumb)
  end
end
