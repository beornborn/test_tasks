require 'rails_helper'

shared_examples :update_activity_success do
  it 'success' do
    service.call
    expect(@result.success?).to eq true
    expect(@result.activity.description).to eq new_description
  end
end

describe Activity::UpdateActivity do
  describe '.call' do
    let!(:regular) { create :user, :regular }
    let!(:manager) { create :user, :manager }
    let!(:admin) { create :user, :admin }
    let(:new_description) { 'new description' }

    subject(:service) do
      -> { @result = described_class.call(user: user, id: activity.id, params: {description: new_description}) }
    end

    context 'user regular' do
      let(:user) { create :user, :regular }

      context 'owner' do
        let(:activity) { create :activity, user: user }
        it_behaves_like :update_activity_success
      end

      context 'regular' do
        let(:activity) { create :activity, user: regular }
        it_behaves_like :pundit_not_authorized
      end

      context 'manager' do
        let(:activity) { create :activity, user: manager }
        it_behaves_like :pundit_not_authorized
      end

      context 'admin' do
        let(:activity) { create :activity, user: admin }
        it_behaves_like :pundit_not_authorized
      end
    end

    context 'user manager' do
      let(:user) { create :user, :manager }

      context 'owner' do
        let(:activity) { create :activity, user: user }
        it_behaves_like :update_activity_success
      end

      context 'regular' do
        let(:activity) { create :activity, user: regular }
        it_behaves_like :pundit_not_authorized
      end

      context 'manager' do
        let(:activity) { create :activity, user: manager }
        it_behaves_like :pundit_not_authorized
      end

      context 'admin' do
        let(:activity) { create :activity, user: admin }
        it_behaves_like :pundit_not_authorized
      end
    end

    context 'user admin' do
      let(:user) { create :user, :admin }

      context 'owner' do
        let(:activity) { create :activity, user: user }
        it_behaves_like :update_activity_success
      end

      context 'regular' do
        let(:activity) { create :activity, user: regular }
        it_behaves_like :update_activity_success
      end

      context 'manager' do
        let(:activity) { create :activity, user: manager }
        it_behaves_like :update_activity_success
      end

      context 'admin' do
        let(:activity) { create :activity, user: admin }
        it_behaves_like :pundit_not_authorized
      end
    end
  end
end
