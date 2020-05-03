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

  def input_options(elem_type, resource, field_name, url, read_only = false)
    { name: field_name,
      name_title: resource.class.human_attribute_name(field_name),
      name_hint: I18n.t("#{resource.class.name.underscore}.show.#{field_name}_hint"),
      resource_class: resource.class.name.underscore,
      submit_button_text: I18n.t('send'),
      cancel_button_text: I18n.t('cancel'),
      url: url,
      start_value: resource.send(field_name).to_s,
      edit_element_type: elem_type,
      read_only: read_only }
  end

  def avatar_input_options(resource, field_name, url, read_only = false)
    { name: field_name,
      name_title: resource.class.human_attribute_name(field_name),
      name_hint: I18n.t("#{resource.class.name.underscore}.show.#{field_name}_hint"),
      resource_class: resource.class.name.underscore,
      submit_button_text: I18n.t('send'),
      cancel_button_text: I18n.t('cancel'),
      url: url,
      image_path: resource.avatar,
      read_only: read_only }
  end

  def image_input_options(resource, field_name, url, start_value, read_only = false)
    { name: field_name,
      name_title: resource.class.human_attribute_name(field_name),
      name_hint: I18n.t("#{resource.class.name.underscore}.show.#{field_name}_hint"),
      resource_class: resource.class.name.underscore,
      submit_button_text: I18n.t('send'),
      cancel_button_text: I18n.t('cancel'),
      url: url,
      image_path: start_value,
      read_only: read_only }
  end

  def rc_string_field(resource, field_name, url, read_only = false)
    react_component 'editable_fields/EditableField', input_options('string', resource, field_name, url, read_only)
  end

  def rc_number_field(resource, field_name, url, read_only = false)
    react_component 'editable_fields/EditableField', input_options('number', resource, field_name, url, read_only)
  end

  def rc_text_field(resource, field_name, url, read_only = false)
    react_component 'editable_fields/EditableField', input_options('text', resource, field_name, url, read_only)
  end


  def rc_avatar_field(resource, field_name, url, read_only = false)
    react_component 'editable_fields/EditableAvatar', avatar_input_options(resource, field_name, url, read_only)
  end

  def rc_image_field(resource, field_name)
    react_component 'editable_fields/ImageUploadField', input_options('', resource, field_name, '', false)
  end

  def rc_edit_image_field(resource, field_name, url, start_value, read_only = false)
    react_component 'editable_fields/EditableImage', image_input_options(resource, field_name, url, start_value,  read_only)
  end
end
