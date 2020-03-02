# encoding: utf-8
class PicturesController < ApplicationController
  def show
    get_resource
  end

  def index
    get_collection
  end

  def new
    @user = User.find(params.required(:user_id))
    @gallery = Gallery.find(params.required(:gallery_id))
    @resource = Picture.new(gallery_id: params.required(:gallery_id))
  end

  def create
    @resource = Picture.create(picture_params.merge({ state: 'active' }))
    if @resource.persisted?
      redirect_to user_gallery_path(user_id: params[:user_id], id: params[:gallery_id])
      return
    end
    @user = User.find(params.required(:user_id))
    @gallery = Gallery.find(params.required(:gallery_id))
    render :new
  end

  private

  def picture_params
    params.required(:picture).permit(:name, :description, :gallery_id, :image)
  end
end
