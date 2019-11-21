require 'rails_helper'

shared_examples :get_user_success do
  it 'success' do
    service.call
    expect(@result.success?).to eq true
    expect(@result.user).to eq target
  end
end

describe User::GetUser do
  describe '.call' do
    let!(:regular) { create :user, :regular }
    let!(:manager) { create :user, :manager }
    let!(:admin) { create :user, :admin }

    subject(:service) do
      -> { @result = described_class.call(user: user, id: target.id) }
    end

    context 'user regular' do
      let(:user) { create :user, :regular }

      context 'owner' do
        let(:target) { user }
        it_behaves_like :get_user_success
      end

      context 'regular' do
        let(:target) { regular }
        it_behaves_like :pundit_not_authorized
      end

      context 'manager' do
        let(:target) { manager }
        it_behaves_like :pundit_not_authorized
      end

      context 'admin' do
        let(:target) { admin }
        it_behaves_like :pundit_not_authorized
      end
    end

    context 'user manager' do
      let(:user) { create :user, :manager }

      context 'owner' do
        let(:target) { user }
        it_behaves_like :get_user_success
      end

      context 'regular' do
        let(:target) { regular }
        it_behaves_like :get_user_success
      end

      context 'manager' do
        let(:target) { manager }
        it_behaves_like :pundit_not_authorized
      end

      context 'admin' do
        let(:target) { admin }
        it_behaves_like :pundit_not_authorized
      end
    end

    context 'user admin' do
      let(:user) { create :user, :admin }

      context 'owner' do
        let(:target) { user }
        it_behaves_like :get_user_success
      end

      context 'regular' do
        let(:target) { regular }
        it_behaves_like :get_user_success
      end

      context 'manager' do
        let(:target) { manager }
        it_behaves_like :get_user_success
      end

      context 'admin' do
        let(:target) { admin }
        it_behaves_like :pundit_not_authorized
      end
    end
  end
end
