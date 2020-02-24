require 'rails_helper'
require 'controllers/auth/simple_shared_examples'
require 'controllers/auth/main_shared_examples'


RSpec.describe OmniauthCallbacksController, :type => :controller do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  it_should_behave_like 'do_omniauth' do
    let!(:controller_action) { :facebook }
    let!(:request_env) { { 'provider' => 'facebook',
                           'extra' => { 'user_hash' => { 'email' => 'test@email.info',
                                                         'name' => 'test_name',
                                                         'id' => 'uid123' } } } }
  end

  it_should_behave_like 'do_omniauth' do
    let!(:controller_action) { :facebook }
    let!(:request_env) { { 'provider' => 'facebook',
                           'extra' => { 'user_hash' => { 'email' => nil,
                                                         'name' => 'test_name',
                                                         'id' => 'uid123' } } } }
  end

  it_should_behave_like 'do_omniauth' do
    let!(:controller_action) { :github }
    let!(:request_env) { { 'provider' => 'github',
                           'extra' => { 'raw_info' => { 'email' => nil,
                                                         'name' => 'test_name',
                                                         'id' => 'uid123' } } } }
  end

  it_should_behave_like 'do_omniauth' do
    let!(:controller_action) { :vkontakte }
    let!(:request_env) { { 'provider' => 'vkontakte',
                           'extra' => { 'raw_info' => { 'email' => nil,
                                                        'last_name' => 'last_name',
                                                        'first_name' => 'first_name',
                                                        'id' => 'uid123' } } } }
  end


  it_should_behave_like 'create_user_and_service' do
    let!(:controller_action) { :create_user_and_service }
    let!(:session) { { 'aut_data' => { 'email' => 'test@email.info',
                                       'name' => 'test_name',
                                       'id' => 'uid123',
                                       'provider' => 'facebook' } } }
  end
end