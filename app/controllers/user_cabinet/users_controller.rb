# encoding: utf-8
module UserCabinet
  class UsersController < PrivateUserController

    def menu_action_items
      ['user']
    end
  end
end