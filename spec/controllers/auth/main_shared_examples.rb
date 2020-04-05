shared_examples 'do_omniauth' do
  context 'when bad request' do
    it 'should redirect to login page' do
      get controller_action
      expect(response).to redirect_to new_user_session_path
    end

    it 'should redirect to login page' do
      request_env = { }
      request.env['omniauth.auth'] = request_env
      get controller_action
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when good request' do
    context 'when user does not exist' do

      it_should_behave_like 'redirect to service_sign_up_users'
      it_should_behave_like 'set session'
    end

    context 'when user already exists' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }

      it_should_behave_like 'redirect to service_sign_up_users'
      it_should_behave_like 'set session'


      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # НЕ должен создавать service
      it_should_behave_like 'should not create service'
    end

    context 'when user already exists and has another service' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'test@email.info',
                                          provider: controller_action.to_s + '_another', user: user) }

      it_should_behave_like 'redirect to service_sign_up_users'
      it_should_behave_like 'set session'

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # НЕ Должен создавать service
      it_should_behave_like 'should not create service'
     end


    context 'when user already exists and signed in and service exists' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'another_email@email.info',
                                          provider: controller_action.to_s,
                                          uid: 'uid123',
                                          user: user) }
      before :each do
        sign_in(user)
      end

      it_should_behave_like 'redirect to authenticated_root'

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # НЕ должен создавать service
      it_should_behave_like 'should not create service'

      # НЕ должен присоединять service к user
      it_should_behave_like 'should not add service to user'
    end

    context 'when user already exists and signed in and service exists and we add another service' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'another_email@email.info',
                                          provider: controller_action.to_s + '_another_service',
                                          uid: 'uid123',
                                          user: user) }
      before :each do
        sign_in(user)
      end

      it_should_behave_like 'redirect to authenticated_root'

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # должен создавать service
      it_should_behave_like 'should create service'

      # должен присоединять service к user
      it_should_behave_like 'should add service to user'
    end

    context 'when user already exists and signed in and service exists but for another user' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:another_user) { FactoryGirl.create(:user, email: 'another_user@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'another_email@email.info',
                                          provider: controller_action.to_s,
                                          uid: 'uid123',
                                          user: another_user) }
      before :each do
        sign_in(user)
      end

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # НЕ должен создавать service
      it_should_behave_like 'should not create service'

      # НЕ должен присоединять service к user
      it_should_behave_like 'should not add service to user'

      it_should_behave_like 'redirect to login page'
    end

    context 'when user already exists and signed in but service does not exist' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }

      before :each do
        sign_in(user)
      end

      it_should_behave_like 'redirect to authenticated_root'

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # Должен создавать service
      it_should_behave_like 'should create service'

      # Должен присоединять service к user
      it_should_behave_like 'should add service to user'
    end


  end
end

shared_examples 'create_user_and_service' do
  context 'when user does not exist' do
    let!(:user_param_hash) { { email: '123456@mail.info', password: '123456', password_confirmation: '123456' } }

    it_should_behave_like 'create_user_and_service redirect to authenticated_root'

    it_should_behave_like 'create_user_and_service should create user'
    it_should_behave_like 'create_user_and_service should create service'
  end

  context 'when user already exists' do
    let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
    let!(:user_param_hash) { { email: 'test@email.info', password: '123456', password_confirmation: '123456' } }

    it_should_behave_like 'create_user_and_service redirect to service_sign_up_users'

    # НЕ должен создавать пользователя
    it_should_behave_like 'create_user_and_service should not create user'

    # НЕ Должен создавать service
    it_should_behave_like 'create_user_and_service should not create service'

    # НЕ Должен присоединять service
    it_should_behave_like 'create_user_and_service should not add service to user'

  end

  context 'when bad parameters' do
    it_should_behave_like 'create_user_and_service redirect to service_sign_up_users' do
      let!(:user_param_hash) { { email: '', password: '123456', password_confirmation: '123456' } }
    end

    it_should_behave_like 'create_user_and_service redirect to service_sign_up_users' do
      let!(:user_param_hash) { { email: 'test@email.info', password: '', password_confirmation: '' } }
    end

    it_should_behave_like 'create_user_and_service redirect to service_sign_up_users' do
      let!(:user_param_hash) { { email: 'test@email.info', password: '', password_confirmation: '123456' } }
    end

    it_should_behave_like 'create_user_and_service redirect to service_sign_up_users' do
      let!(:user_param_hash) { { email: 'test@email.info', password: '654321', password_confirmation: '123456' } }
    end
  end
end
