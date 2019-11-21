def json
  JSON.parse(response.body)
end

def current_user_is user
  allow(controller).to receive(:current_user) { user }
end
