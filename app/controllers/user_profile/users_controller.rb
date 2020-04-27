# encoding: utf-8
module UserProfile
  class UsersController < ApplicationController

    def update
      super do
        @resource.update(user_profile_params)
        if @resource.errors.count == 0
          render json: @resource, status: :ok, location: @resource
        else
          render json: @resource.errors, status: :unprocessable_entity
        end
      end
    end

    def menu_action_items
      ['user']
    end

    def user_profile_params
      params.required(:user).permit(:email, :avatar, :nick_name)
    end
  end
end