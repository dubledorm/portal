module MenuConcern
  extend ActiveSupport::Concern

  def menu_action_items
    return ['user'] if controller_name == 'registrations' && action_name == 'edit'
    return ['login'] if %w(sessions registrations omniauth_callbacks).include?(controller_name)
    return ['user'] if devise_controller?
    ['home']
  end
end