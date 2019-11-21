require 'rails_helper'

describe SignupUser do
  describe '.call' do
    subject(:signup) do
      @result = described_class.call(params)
    end

    # -----------------------------------------------------------------------------------

    context 'valid params' do
      let(:params) do
        {
          email: 'some@email.com',
          password: 'valid',
          name: 'some name',
        }
      end
      let(:token) { 'token' }

      before do
        allow(Auth).to receive(:issue).and_return(token)
        signup
      end

      it 'success' do
        expect(@result.success?).to eq true
      end

      it 'creates user' do
        expect(@result.user).to eq User.last
        expect(@result.user.email).to eq params[:email]
      end

      it 'generates token' do
        expect(@result.token).to eq token
      end

      it 'adds regular role' do
        expect(@result.user.is_regular?).to eq true
      end
    end

    # -----------------------------------------------------------------------------------

    context 'invalid params' do
      let(:params) do
        {
          email: 'some@email.com',
          password: '',
          name: 'some name',
        }
      end

      before { signup }

      it 'dont success' do
        expect(@result.success?).to eq false
      end

      it 'doesnt create user' do
        expect(@result.user).to be_nil
        expect(User.last).to be_nil
        expect(@result.error).to eq(password: ['is too short (minimum is 3 characters)'])
      end
    end
  end
end
