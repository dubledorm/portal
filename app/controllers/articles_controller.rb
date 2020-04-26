# encoding: utf-8
class ArticlesController < ApplicationController

  include ArticleConcern

  def show
    super do
      @user = User.find(params.required(:user_id))
    end
  end
end
