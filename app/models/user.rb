class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  enum role: [:admin, :manager, :cashier, :salesman, :normal_user]
  paginates_per 3
  #after_create :send_user_mail
  def send_user_mail
        # Tell the UserMailer to send a welcome email after save
        UserMailer.welcome_email(self).deliver_now
        p self.inspect
  end
  def to_s
    return first_name unless first_name.blank?
    email
  end

  def self.search(search)
    if search
      #self.joins(:category)
        #.where("categories.name like ? OR products.name like ? " , "#{search}%" , "#{search}%")
         where("email like ?", "#{search}%")
    end
  end
end
