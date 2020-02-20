shared_examples 'redirect to login page' do
  it 'should redirect to login page' do
    request.env['omniauth.auth'] = request_env if defined?(request_env)
    get controller_action
    expect(response).to redirect_to new_user_session_path
  end
end

shared_examples 'redirect to authenticated_root' do
  it 'should redirect to authenticated_root' do
    request.env['omniauth.auth'] = request_env
    get controller_action
    expect(response).to redirect_to authenticated_root_path
  end
end

shared_examples 'should create user' do
  it 'should create user' do
    request.env['omniauth.auth'] = request_env
    expect{ get controller_action }.to change(User, :count).by(1)
  end
end

shared_examples 'should create service' do
  it 'should create service' do
    request.env['omniauth.auth'] = request_env
    expect{ get controller_action }.to change(Service, :count).by(1)
  end
end

shared_examples 'should not create user' do
  it 'should not create user' do
    request.env['omniauth.auth'] = request_env
    expect{ get controller_action }.to change(User, :count).by(0)
  end
end

shared_examples 'should not create service' do
  it 'should not create service' do
    request.env['omniauth.auth'] = request_env
    expect{ get controller_action }.to change(Service, :count).by(0)
  end
end

shared_examples 'should add service to user' do
  it 'should create service' do
    request.env['omniauth.auth'] = request_env
    expect{ get controller_action }.to change(user.services, :count).by(1)
  end
end

shared_examples 'should not add service to user' do
  it 'should create service' do
    request.env['omniauth.auth'] = request_env
    expect{ get controller_action }.to change(user.services, :count).by(0)
  end
end
