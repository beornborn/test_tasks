require 'rails_helper'

describe V1::SessionsController do
  describe 'POST create' do
    let(:params) do
      {
        email: 'some@email.com',
        password: 'valid',
      }
    end
    let(:result) { double }
    let(:user) { create :user, :regular }
    let(:error) { 'some error' }
    let(:token) { 'token' }

    subject(:login) do
      post :create, params: params
    end

    before do
      allow(LoginUser).to receive(:call).and_return(result)
    end

    context 'successfull login' do
      before do
        allow(result).to receive(:success?).and_return(true)
        allow(result).to receive(:user).and_return(user)
        allow(result).to receive(:token).and_return(token)
        login
      end

      it 'return user' do
        expect(json['user']['name']).to eq(user.name)
      end

      it 'return token' do
        expect(json['token']).to eq(token)
      end
    end

    context 'unsuccessfull login' do
      before do
        allow(result).to receive(:success?).and_return(false)
        allow(result).to receive(:error).and_return(error)
        login
      end

      it 'return error' do
        expect(json['error']).to eq(error)
      end
    end
  end
end
