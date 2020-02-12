class ServicesController < ApplicationController
  def index
  end

  def create
    render :text => request.env["omniauth.auth"].to_yaml
    # http://www.facebook.com/profile.php?id=659296247736629
  end
end
