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

  def input_options(elem_type, resource, field_name, url)
    { name: field_name,
      name_title: resource.class.human_attribute_name(field_name),
      name_hint: I18n.t("#{resource.class.name.underscore}.show.#{field_name}_hint"),
      resource_class: resource.class.name.underscore,
      submit_button_text: I18n.t('send'),
      cancel_button_text: I18n.t('cancel'),
      url: url,
      start_value: resource.decorate.send(field_name).to_s,
      edit_element_type: elem_type }

  end
end
