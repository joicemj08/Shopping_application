class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  enum role: [:admin, :manager, :cashier, :salesman]
  paginates_per 3

  def to_s
    return first_name unless first_name.blank?
    email
  end
end
