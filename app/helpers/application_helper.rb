module ApplicationHelper

  def errors_to_str(resource)
    resource.errors.full_messages.join('<br/>')
  end

  def active_menu_item(name)
    return '' if @active_menu_items.nil?
    @active_menu_items.include?(name) ? 'active' : ''
  end

  def divide_for_two_columns(records)
    half_records_count = records.count / 2
    i = -1
    records.partition{ |record| i +=1; i < half_records_count }
  end
end
