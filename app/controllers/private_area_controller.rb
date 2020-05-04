# encoding: utf-8
class PrivateAreaController < ApplicationController
  before_action :authenticate_user!

end