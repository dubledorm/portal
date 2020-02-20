require 'rails_helper'
require 'controllers/auth/simple_shared_examples'
require 'controllers/auth/main_shared_examples'


RSpec.describe OmniauthCallbacksController, :type => :controller do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  it_should_behave_like 'auth service' do
    let!(:controller_action) { :facebook }
    let!(:request_env) { { 'provider' => 'facebook',
                           'extra' => { 'user_hash' => { 'email' => 'test@email.info',
                                                         'name' => 'test_name',
                                                         'id' => 'uid123' } } } }
  end
end