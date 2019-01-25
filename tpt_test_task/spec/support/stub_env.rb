RSpec.configure do
  def stub_env(key, value)
    allow(ENV).to receive(:[]).with(key).and_return(value)
  end
end
