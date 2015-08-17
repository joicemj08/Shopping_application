module ApplicationHelper

  def css_class_for_li(page_name)
    classes = []
    classes.push('active')if is_active?(page_name)
    classes.push('not-visible') unless link_visible?(page_name)
    classes.join(' ')
  end

  def link_visible?(page_name)
    if current_user.manager?
      pages = ['dashboard', 'products', 'categories', 'users', 'offers']
    else
      pages = ['products', 'categories']
    end

    pages.include?(page_name)
  end
end
