# encoding: utf-8
class PrivateAreaController < ApplicationController
  before_action :authenticate_user!

  def get_resource
    @resource = current_user
  end
end