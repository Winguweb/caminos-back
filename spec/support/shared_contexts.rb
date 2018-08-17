RSpec.shared_context 'a successful request' do
  it { expect(response).to have_http_status(:success) }
end

RSpec.shared_context 'a redirect' do |redirect_path|
  it "a redirect to '#{redirect_path}'" do
    expect(response).to have_http_status(302)
    # TODO:
    # expect(response).to redirect_to(redirect_path)
  end
end
