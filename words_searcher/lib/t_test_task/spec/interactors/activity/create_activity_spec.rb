require 'rails_helper'

shared_examples :create_activity_success do
  it 'success' do
    service.call
    expect(@result.success?).to eq true
    expect(@result.activity.description).to eq params[:description]
    expect(@result.activity.start).to eq params[:start]
    expect(@result.activity.user).to eq target_user
    expect(@result.activity.duration).to eq params[:duration]
  end
end

describe Activity::CreateActivity do
  describe '.call' do
    let!(:regular) { create :user, :regular }
    let!(:manager) { create :user, :manager }
    let!(:admin) { create :user, :admin }
    let(:params) {
      {
        description: 'new description',
        start: Date.today,
        user_id: target_user.id,
        duration: 100,
      }
    }

    subject(:service) do
      -> { @result = described_class.call(user: user, params: params) }
    end

    context 'user regular' do
      let(:user) { create :user, :regular }

      context 'owner' do
        let(:target_user) { user }
        it_behaves_like :create_activity_success
      end

      context 'regular' do
        let(:target_user) { regular }
        it_behaves_like :pundit_not_authorized
      end

      context 'manager' do
        let(:target_user) { manager }
        it_behaves_like :pundit_not_authorized
      end

      context 'admin' do
        let(:target_user) { admin }
        it_behaves_like :pundit_not_authorized
      end
    end

    context 'user manager' do
      let(:user) { create :user, :manager }

      context 'owner' do
        let(:target_user) { user }
        it_behaves_like :create_activity_success
      end

      context 'regular' do
        let(:target_user) { regular }
        it_behaves_like :pundit_not_authorized
      end

      context 'manager' do
        let(:target_user) { manager }
        it_behaves_like :pundit_not_authorized
      end

      context 'admin' do
        let(:target_user) { admin }
        it_behaves_like :pundit_not_authorized
      end
    end

    context 'user admin' do
      let(:user) { create :user, :admin }

      context 'owner' do
        let(:target_user) { user }
        it_behaves_like :create_activity_success
      end

      context 'regular' do
        let(:target_user) { regular }
        it_behaves_like :create_activity_success
      end

      context 'manager' do
        let(:target_user) { manager }
        it_behaves_like :create_activity_success
      end

      context 'admin' do
        let(:target_user) { admin }
        it_behaves_like :pundit_not_authorized
      end
    end
  end
end
