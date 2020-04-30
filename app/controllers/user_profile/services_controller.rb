# encoding: utf-8
module UserProfile
  class ServicesController < ApplicationController

    def destroy
      super
      redirect_to(user_profile_user_path(id: params.required(:user_id)))
    end
  end
end
