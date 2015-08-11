module HighlightHelper
  def is_active?(page_controller)
    if params[:controller] == page_controller
      true
    else
      false
    end
  end
end