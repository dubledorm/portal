# encoding: utf-8
class UsersController < ApplicationController
  def show
    super do
      @mode = params[:mode].present? ? params[:mode] : 'profile'
      @services = @resource.services
    end
  end

  def update
    super do
      ActiveRecord::Base.transaction do
        # Категории
        if params.required(:user)[:categories].present?
          params.required(:user)[:categories].keys.each do |category_name|
            @resource.add_category(category_name)
          end
        end
      end
      redirect_to user_path(id: @resource.id, mode: 'cabinet')
    end
  end

  def menu_action_items
    ['user']
  end

  def user_params
    params.required(:user).permit(:main_image, :categories)
  end
end
