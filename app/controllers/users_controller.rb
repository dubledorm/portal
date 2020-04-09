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
      byebug
      redirect_to user_path(id: @resource.id, mode: 'cabinet')
    end
  end

  def menu_action_items
    ['user']
  end
end
