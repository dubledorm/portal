require 'rails_helper'
require 'support/devise_support'
require 'support/shared/request_shared_examples'



RSpec.describe 'ServicesController', type: :request do
  context 'when bad request' do

    it_should_behave_like 'redirect to login page' do
      subject { get auth_callback_path(service: 'nothing')}
    end
  end

  context 'when good request' do
    before :each do
      Rails.application.env_config['omniauth.auth'] = { 'provider' => 'facebook',
                                                        'extra' => { 'user_hash' => { 'email' => 'test@email.info',
                                                                                      'name' => 'test_name',
                                                                                      'id' => 'uid123' } } }
    end

    context 'when user does not exist' do

      it_should_behave_like 'redirect to authenticated_root' do
        subject { get auth_callback_path(service: 'facebook')}
      end

      # Должен создавать пользователя
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(User, :count).by(1) }

      # Должен создавать service
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(Service, :count).by(1) }
    end

    context 'when user already exists' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }

      it_should_behave_like 'redirect to authenticated_root' do
        subject { get auth_callback_path(service: 'facebook')}
      end

      # НЕ должен создавать пользователя
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(User, :count).by(0) }

      # Должен создавать service
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(Service, :count).by(1) }

      # Должен создавать service
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(user.services, :count).by(1) }
    end

    context 'when user already exists and has another service' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'test@email.info',
                                          provider: 'vkontakte',
                                          user: user) }

      it_should_behave_like 'redirect to authenticated_root' do
        subject { get auth_callback_path(service: 'facebook')}
      end

      # НЕ должен создавать пользователя
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(User, :count).by(0) }

      # Должен создавать service
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(Service, :count).by(1) }

      # Должен присоединять service к user
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(user.services, :count).by(1) }

      it 'user will be have 2 services' do
        get auth_callback_path(service: 'facebook')
        expect(user.services.count).to eq(2)
      end
    end

    context 'when user already exists and signed in and service exists' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'another_email@email.info',
                                          provider: 'facebook',
                                          uid: 'uid123',
                                          user: user) }
      before :each do
        sign_in(user)
      end

      it_should_behave_like 'redirect to authenticated_root' do
        subject { get auth_callback_path(service: 'facebook')}
      end

      # НЕ должен создавать пользователя
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(User, :count).by(0) }

      # НЕ должен создавать service
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(Service, :count).by(0) }

      # НЕ должен присоединять service к user
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(user.services, :count).by(0) }
    end

    context 'when user already exists and signed in and service exists but for another user' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:another_user) { FactoryGirl.create(:user, email: 'another_user@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'another_email@email.info',
                                          provider: 'facebook',
                                          uid: 'uid123',
                                          user: another_user) }
      before :each do
        sign_in(user)
      end

      # НЕ должен создавать пользователя
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(User, :count).by(0) }

      # НЕ должен создавать service
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(Service, :count).by(0) }

      # НЕ должен присоединять service к user
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(user.services, :count).by(0) }

      it_should_behave_like 'redirect to login page' do
        subject{ get auth_callback_path(service: 'facebook')  }
      end
    end

    context 'when user already exists and signed in but service does not exist' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }

      before :each do
        sign_in(user)
      end

      it_should_behave_like 'redirect to authenticated_root' do
        subject { get auth_callback_path(service: 'facebook')}
      end

      # НЕ должен создавать пользователя
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(User, :count).by(0) }

      # Должен создавать service
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(Service, :count).by(1) }

      # Должен присоединять service к user
      it { expect{ get auth_callback_path(service: 'facebook') }.to change(user.services, :count).by(1) }
    end
  end
end