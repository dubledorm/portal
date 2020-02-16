class ServicesController < ApplicationController
  include OmniAuthConcern

 # before_filter :authenticate_user!, :except => [:create]

  def index
    # get all authentication services assigned to the current user
    @services = current_user.services.all
  end

  def destroy
    # remove an authentication service linked to the current user
    @service = current_user.services.find(params[:id])
    @service.destroy

    redirect_to services_path
  end

  def create
    service_route = params.required(:service)
    omniauth = request.env['omniauth.auth']

    begin
      aut_data = get_auth_data(omniauth, service_route)
      sign_in_or_sign_up(aut_data)
      redirect_to authenticated_root_path
    rescue OmniAuthConcern::OmniAuthError => e
      flash[:error] = e.message
      redirect_to new_user_session_path
    end
  end
end
