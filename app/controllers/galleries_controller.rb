# encoding: utf-8
class GalleriesController < ApplicationController
  def show
    get_resource
  end

  def index
    get_collection
  end

  def new
    @user = User.find(params.required(:user_id))
    @resource = Gallery.new(user_id: params.required(:user_id))
  end

  def create
      @resource = Gallery.create!(gallery_params.merge({ state: 'active' }))
      if @resource.persisted?
        redirect_to user_gallery_path(user_id: gallery_params[:user_id], id: @resource.id)
        return
      end
      @user = User.find(params[:user_id])
      render :new
  end

  private

  def gallery_params
    params.required(:gallery).permit(:name, :description, :user_id)
  end
end
