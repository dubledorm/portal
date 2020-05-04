# encoding: utf-8
module UserProfile
  class ServicesController < PrivateAreaController

    def destroy
      super
      redirect_to(user_profile_path)
    end
  end
end
