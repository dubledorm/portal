module ApplicationHelper

  def errors_to_str(resource)
    resource.errors.full_messages.join('<br/>')
  end
end
