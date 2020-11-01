def login_user(user = nil)
  user ||= FactoryBot.create(:user)
  post '/api/v1/auth/sign_in', params: { email: user.email, password: 'secret' }
  return { 'access-token': response['access-token'], 'token-type': response['token-type'], client: response['client'], uid: response['uid'], expiry: response['expiry'], format: :json }
end

def login_admin
  admin = FactoryBot.create(:admin)
  post '/api/v1/auth/sign_in', params: { email: admin.email, password: 'secret' }
  return { 'access-token': response['access-token'], 'token-type': response['token-type'], client: response['client'], uid: response['uid'], expiry: response['expiry'], format: :json }
end
