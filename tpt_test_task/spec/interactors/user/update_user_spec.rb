require 'rails_helper'

shared_examples :update_user_success do
  it 'success' do
    service.call
    expect(@result.success?).to eq true
    expect(@result.updated_user.name).to eq params[:name]
    expect(@result.updated_user.working_minutes).to eq params[:working_minutes]
  end
end

describe User::UpdateUser do
  describe '.call' do
    let!(:regular_user) { create :user, :regular }
    let!(:manager_user) { create :user, :manager }
    let!(:admin_user) { create :user, :admin }
    let(:params) {
      {
        name: 'some new name',
        working_minutes: 5,
      }
    }

    subject(:service) do
      -> { @result = described_class.call(user: user, id: id, params: params) }
    end

    context 'user regular' do
      let(:user) { create :user, :regular }
      let(:id) { regular_user.id }
      it_behaves_like :pundit_not_authorized
    end

    # ------------------------------------------------------------------------

    context 'user manager' do
      let(:user) { create :user, :manager }

      context 'regular user is update' do
        let(:id) { regular_user.id }
        it_behaves_like :update_user_success
      end

      context 'manager user is update' do
        let(:id) { manager_user.id }
        it_behaves_like :pundit_not_authorized
      end
    end

    # ------------------------------------------------------------------------

    context 'user admin' do
      let(:user) { create :user, :admin }

      context 'regular user is update' do
        let(:id) { regular_user.id }
        it_behaves_like :update_user_success
      end

      context 'manager user is update' do
        let(:id) { manager_user.id }
        it_behaves_like :update_user_success
      end

      context 'admin user is update' do
        let(:id) { admin_user.id }
        it_behaves_like :pundit_not_authorized
      end
    end
  end
end
