# encoding: utf-8
class UsersController < ApplicationController
  def show
    super do
      @services = @resource.services
    end
  end

  def menu_action_items
    ['user']
  end
end
