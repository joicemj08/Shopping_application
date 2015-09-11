#
# ApplicationHelper
#
# @author [Joice]
#
module ApplicationHelper
  # method to set visible links
  def css_class_for_li(page_name)
    classes = []
    classes.push('active')if is_active?(page_name)
    classes.push('not-visible') unless link_visible?(page_name)
    classes.join(' ')
  end
  # method to set visible pages for different users
  def link_visible?(page_name)
    if current_user.manager? || current_user.admin?
      pages = ['dashboard', 'home', 'products', 'categories', 'users', 'offers']
    else
      pages = ['home']
    end

    pages.include?(page_name)
  end

  # method to use devise forms in other views
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
