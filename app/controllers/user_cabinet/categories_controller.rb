# encoding: utf-8
module UserCabinet
  class CategoriesController < ApplicationController

    def menu_action_items
      ['user']
    end

    # def user_params
    #   params.required(:user).permit(:main_image, :categories)
    # end
  end
end