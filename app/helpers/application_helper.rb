module ApplicationHelper

  def errors_to_str(resource)
    resource.errors.full_messages.join('<br/>')
  end

  def active_menu_item(name)
    return '' if @active_menu_items.nil?
    @active_menu_items.include?(name) ? 'active' : ''
  end
end
