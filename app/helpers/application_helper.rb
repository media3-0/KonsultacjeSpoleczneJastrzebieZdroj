module ApplicationHelper
  def nav_link(link_text, link_path, title, tab = -1)
    class_name = current_page?(link_path) ? 'active' : nil
    if tab > -1
      link_to link_text, link_path, :class => class_name, title: title, tabindex: tab
    else
      link_to link_text, link_path, :class => class_name, title: title
    end
  end
end
