require 'rails_helper'

describe LoginUser do
  describe '.call' do
    subject(:login) do
      @result = described_class.call(params)
    end

    # -----------------------------------------------------------------------------------

    context 'valid params' do
      let!(:existing_user) { create :user, email: 'email@em.com', password: '123123' }
      let(:params) do
        {
          email: existing_user.email,
          password: '123123',
        }
      end
      let(:token) { 'token' }

      before do
        allow(Auth).to receive(:issue).and_return(token)
        login
      end

      it 'success' do
        expect(@result.success?).to eq true
      end

      it 'return correct user' do
        expect(@result.user).to eq existing_user
      end

      it 'generates token' do
        expect(@result.token).to eq token
      end
    end

    # -----------------------------------------------------------------------------------

    context 'invalid credentials' do
      let(:params) do
        {
          email: 'some@email.com',
          password: '',
        }
      end

      before { login }

      it 'dont success' do
        expect(@result.success?).to eq false
      end

      it 'return error message' do
        expect(@result.user).to be_nil
        expect(@result.error).to eq 'Invalid credentials'
      end
    end
  end
end
