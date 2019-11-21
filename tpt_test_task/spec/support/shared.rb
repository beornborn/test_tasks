RSpec.shared_examples :pundit_not_authorized do
  it 'raise error authorization error' do
    expect { service.call }.to raise_error Pundit::NotAuthorizedError
  end
end
