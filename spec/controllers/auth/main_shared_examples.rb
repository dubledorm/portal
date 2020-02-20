shared_examples 'auth service' do
  context 'when bad request' do
    it 'should redirect to login page' do
      get controller_action
      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'when good request' do

    context 'when user does not exist' do

      it_should_behave_like 'redirect to authenticated_root'
      it_should_behave_like 'should create user'
      it_should_behave_like 'should create service'
    end

    context 'when user already exists' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }

      it_should_behave_like 'redirect to authenticated_root'

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # Должен создавать service
      it_should_behave_like 'should create service'

      # Должен присоединять service
      it_should_behave_like 'should add service to user'

    end

    context 'when user already exists and has another service' do
      let!(:user) { FactoryGirl.create(:user, email: 'test@email.info') }
      let!(:service) { FactoryGirl.create(:service, uemail: 'test@email.info',
                                          provider: 'vkontakte',
                                          user: user) }

      it_should_behave_like 'redirect to authenticated_root'

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # Должен создавать service
      it_should_behave_like 'should create service'

      # Должен присоединять service к user
      it_should_behave_like 'should add service to user'

      it 'user will be have 2 services' do
        request.env['omniauth.auth'] = request_env
        get controller_action
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

      it_should_behave_like 'redirect to authenticated_root'

      # НЕ должен создавать пользователя
      it_should_behave_like 'should not create user'

      # НЕ должен создавать service
      it_should_behave_like 'should not create service'

      # НЕ должен присоединять service к user
      it_should_behave_like 'should not add service to user'
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