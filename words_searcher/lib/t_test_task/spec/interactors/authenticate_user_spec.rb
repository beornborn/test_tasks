require 'rails_helper'

describe AuthenticateUser do
  describe '.call' do
    subject(:authenticate) do
      @result = described_class.call(headers: {'X-AUTH-TOKEN' => token})
    end

    context 'user found' do
      let(:user) { create :user, email: 'email@em.com', password: '123123' }
      let(:token) { Auth.issue({id: user.id}) }

      before { authenticate }

      it 'success' do
        expect(@result.success?).to eq true
      end

      it 'return correct user' do
        expect(@result.user).to eq user
      end
    end

    context 'user not found' do
      let(:token) { '123' }

      before { authenticate }

      it 'dont success' do
        expect(@result.success?).to eq false
      end
    end
  end
end
