# encoding: utf-8
module UserCabinet
  class UsersController < PrivateUserController

    def update
      super do
        @resource.update(user_cabinet_params)
        if @resource.errors.count == 0
          render json: attributes_mask_to_json(@resource, user_cabinet_params),  status: :ok
        else
          render json: @resource.errors.full_messages.joins(', '), status: :unprocessable_entity
        end
      end
    end

    def menu_action_items
      ['user']
    end

    def user_cabinet_params
      params.required(:user).permit(:main_image)
    end
  end
end