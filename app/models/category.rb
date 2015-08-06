class Category < ActiveRecord::Base
  validates :code, presence: true,
                   length: { minimum: 3 }
  validates_presence_of :code, :name
  validates_uniqueness_of :code, :name
  has_many :products, dependent: :destroy
  def self.search(search)
    if search
      self.where("name like ?", "%#{search}%")
    end
  end
end
