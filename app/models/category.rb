class Category < ActiveRecord::Base
  validates :code, presence: true,
                   length: { minimum: 3 }
  validates_presence_of :name
  validates_uniqueness_of :code, :name
  has_many :products, dependent: :destroy
  has_many :sub_categories, class_name: "Category", foreign_key: "category_id"
  accepts_nested_attributes_for :sub_categories, reject_if: :all_blank, allow_destroy: true
  belongs_to :category, class_name: "Category"
  paginates_per 3

  def self.search(search)
    if search
      where("name like ?", "#{search}%")
    else
      all
    end
  end
end
