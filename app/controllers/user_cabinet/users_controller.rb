# encoding: utf-8
module UserCabinet
  class UsersController < PrivateUserController

    def update
      super do
        presenter = UserCabinetPresenter.new(user_cabinet_params)
        presenter.update(@resource)
        if presenter.errors.count == 0
          render json: attributes_mask_to_json(@resource, user_cabinet_params),  status: :ok
        else
          render json: presenter.errors_to_json, status: :unprocessable_entity
        end
      end
    end

    def menu_action_items
      ['user']
    end

    def user_cabinet_params
      params.required(:user).permit(:main_image, :main_description)
    end
  end
end