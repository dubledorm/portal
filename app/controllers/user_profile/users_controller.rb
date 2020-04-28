# encoding: utf-8

module UserProfile
  class UsersController < ApplicationController

    def update
      super do
        @resource.update(user_profile_params)
        if @resource.errors.count == 0
          render json: {avatar: image_path(@resource),
                        nick_name: @resource.nick_name
          }, status: :ok, location: @resource
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end
    end

    def menu_action_items
      ['user']
    end

    def user_profile_params
      params.required(:user).permit(:avatar, :nick_name)
    end

  private

    def image_path(user)
      user.avatar.attached? ? url_for(user.avatar.variant(resize_to_limit: [200, 200])) : ''
    end
  end
end