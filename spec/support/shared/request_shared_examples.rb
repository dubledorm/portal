RSpec.shared_examples 'redirect to login page' do
  it 'should redirect to login page' do
    expect(subject).to redirect_to(new_user_session_path)
  end
end

RSpec.shared_examples 'redirect to authenticated_root' do
  it 'should redirect to login page' do
    expect(subject).to redirect_to(authenticated_root_path)
  end
end

RSpec.shared_examples 'get response 403' do
  it 'response' do
    subject
    expect(response).to have_http_status(403)
  end
end

RSpec.shared_examples 'get response 404' do
  it 'response' do
    subject
    expect(response).to have_http_status(404)
    ap(response.body)
  end
end

RSpec.shared_examples 'get response 400' do
  it 'response' do
    subject
    expect(response).to have_http_status(400)
    ap(response.body)
  end
end

