require 'rails_helper'

describe V1::UsersController do
  describe 'GET index' do
    subject(:index) { get :index }
    let(:user) { build :user }

    before do
      current_user_is user
      allow(User::GetUsers).to receive(:call).and_return(result)
    end

    context 'success' do
      let(:result) { double(success?: true, users: 'users'.to_json) }
      before { index }

      it 'return users' do
        expect(json['users']).to eq 'users'
      end
    end

    context 'failure' do
      let(:result) { double(success?: false, error: 'error') }
      before { index }

      it 'return error' do
        expect(json['error']).to eq 'error'
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'GET me' do
    subject(:me) { get :me }
    let!(:user) { create :user, :regular }

    before do
      current_user_is user
      me
    end

    it 'return user' do
      expect(json['user']['name']).to eq user.name
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'GET show' do
    subject(:show) { get :show, params: { id: user.id } }
    let(:user) { create :user, :regular }

    before do
      current_user_is user
      allow(User::GetUser).to receive(:call).and_return(result)
    end

    context 'success' do
      let(:result) { double(success?: true, user: 'user'.to_json) }
      before { show }

      it 'return users' do
        expect(json['user']).to eq 'user'
      end
    end

    context 'failure' do
      let(:result) { double(success?: false, error: 'error') }
      before { show }

      it 'return error' do
        expect(json['error']).to eq 'error'
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'POST create' do
    let(:params) do
      {
        email: 'some@email.com',
        password: 'valid',
        name: 'some name',
      }
    end
    let(:result) { double }
    let(:user) { create :user, :regular }
    let(:error) { 'some error' }
    let(:token) { 'token' }

    subject(:signup) do
      post :create, params: params
    end

    before do
      allow(SignupUser).to receive(:call).and_return(result)
    end

    context 'successfull signup' do
      before do
        allow(result).to receive(:success?).and_return(true)
        allow(result).to receive(:user).and_return(user)
        allow(result).to receive(:token).and_return(token)
        signup
      end

      it 'return user' do
        expect(json['user']['name']).to eq(user.name)
      end

      it 'return token' do
        expect(json['token']).to eq(token)
      end
    end

    context 'unsuccessfull signup' do
      before do
        allow(result).to receive(:success?).and_return(false)
        allow(result).to receive(:error).and_return(error)
        signup
      end

      it 'return error' do
        expect(json['error']).to eq(error)
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'POST update' do
    let(:params) do
      {
        id: user.id,
        name: 'some name',
        working_minutes: 100,
      }
    end
    let(:user) { create :user, :regular }
    let(:error) { 'some error' }

    subject(:update) do
      post :update, params: params
    end

    before do
      current_user_is user
      allow(User::UpdateUser).to receive(:call).and_return(result)
      update
    end

    context 'successfull update' do
      let(:result) { double(success?: true, updated_user: 'user'.to_json) }

      it 'return user' do
        expect(json).to eq('user')
      end
    end

    context 'unsuccessfull update' do
      let(:result) { double(success?: false, error: 'error') }

      it 'return error' do
        expect(json['error']).to eq('error')
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'DELETE destroy' do
    subject(:destroy) { delete :destroy, params: { id: 1 } }
    let(:user) { build :user }

    before do
      current_user_is user
    end

    context 'success' do
      let(:result) { double }
      before do
        allow(User::DeleteUser).to receive(:call).and_return(result)
        destroy
      end

      it 'return success' do
        expect(response.status).to eq 200
        expect(json).to eq({})
      end
    end

    context 'failure' do
      let(:result) { double(success?: false, error: 'error') }
      before do
        allow(User::DeleteUser).to receive(:call).and_raise(::ActiveRecord::RecordNotFound)
        destroy
      end

      it 'return error' do
        expect(json['error']).to eq 'ActiveRecord::RecordNotFound'
        expect(response.status).to eq 404
      end
    end
  end
end
