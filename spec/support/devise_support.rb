require 'rails_helper'

module DeviseSupport
  def sign_in_user
    @user ||= FactoryGirl.create :user
    @user.confirm #if you are using the "confirmable" module
    sign_in @user
  end

  def sign_out_user
    sign_out @user
  end
end