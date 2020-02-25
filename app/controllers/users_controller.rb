# encoding: utf-8
class UsersController < ApplicationController
  def show
    get_resource
    @services = @resource.services
  end
end
