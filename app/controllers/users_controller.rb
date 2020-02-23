# encoding: utf-8
class UsersController < ApplicationController
  def show
    find_resource
    @services = @resource.services
  end
end
