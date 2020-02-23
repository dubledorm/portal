require 'auth/service_descr_manager'
require 'auth/omni_auth_error'

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniAuthConcern

  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        do_omniauth
      end
    }
  end

  Auth::ServiceDescrManager::KNOWN_SERVICES_DESCR.keys.each do |provider|
    provides_callback_for provider
  end

  def failure
    redirect_to root_path
  end

  # It provides central callback for OmniAuth
  def do_omniauth
    if params.has_key?(:service_route)
      @service_route = params.required(:service_route)
      omniauth = JSON.parse(params.required(:omniauth))
      email = params.required(:email)
      omniauth['extra']['raw_info']['email'] = email
    else
      @service_route = params.required(:action)
      omniauth = request.env['omniauth.auth']
    end

    begin
      aut_data = get_auth_data(omniauth, @service_route)
      ap(aut_data)
      sign_in_or_sign_up(aut_data)
      redirect_to authenticated_root_path
    rescue Auth::OmniAuthEmailBlank
      @omniauth_json = omniauth.to_json
      render 'devise/sessions/additional_parameters'
    rescue Auth::OmniAuthError => e
      flash[:error] = e.message
      redirect_to new_user_session_path
    end
  end
end