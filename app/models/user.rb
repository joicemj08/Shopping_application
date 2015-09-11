#
# UserClass
#
# @author [joice]
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' },
                             default_url: '/images/missing.jpg'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  enum role: [:admin, :manager, :cashier, :salesman, :normal_user]
  validates_presence_of :first_name, :last_name
  paginates_per 3
  # after_create :send_user_mail
  def send_user_mail
    # Tell the UserMailer to send a welcome email after save
    UserMailer.welcome_email(self).deliver_now
  end
  #returns email if first name is not present
  def to_s
    return first_name unless first_name.blank?
    email
  end
end
