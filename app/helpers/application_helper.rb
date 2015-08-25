module ApplicationHelper

  def css_class_for_li(page_name)
    classes = []
    classes.push('active')if is_active?(page_name)
    classes.push('not-visible') unless link_visible?(page_name)
    classes.join(' ')
  end

  def link_visible?(page_name)
    if current_user.manager? || current_user.admin?
      pages = ['dashboard', 'home', 'products', 'categories', 'users', 'offers']
    else
      pages = ['dashboard', 'home','products', 'categories']
    end

    pages.include?(page_name)
  end

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
