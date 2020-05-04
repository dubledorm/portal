# encoding: utf-8
class PrivateUserController < ApplicationController
  before_action :authenticate_user!

  def get_resource
    @resource = current_user
  end
end
