require 'rails_helper'

shared_examples :delete_user_success do
  it 'success' do
    service.call
    deleted = User.find_by(id: id)
    expect(@result.success?).to eq true
    expect(deleted).to be_nil
  end
end

describe User::DeleteUser do
  describe '.call' do
    let!(:regular_user) { create :user, :regular }
    let!(:manager_user) { create :user, :manager }
    let!(:admin_user) { create :user, :admin }

    subject(:service) do
      -> { @result = described_class.call(user: user, id: id) }
    end

    context 'user regular' do
      let(:user) { create :user, :regular }
      let(:id) { regular_user.id }
      it_behaves_like :pundit_not_authorized
    end

    # ------------------------------------------------------------------------

    context 'user manager' do
      let(:user) { create :user, :manager }

      context 'regular user is deleted' do
        let(:id) { regular_user.id }
        it_behaves_like :delete_user_success
      end

      context 'manager user is deleted' do
        let(:id) { manager_user.id }
        it_behaves_like :pundit_not_authorized
      end
    end

    # ------------------------------------------------------------------------

    context 'user admin' do
      let(:user) { create :user, :admin }

      context 'regular user is deleted' do
        let(:id) { regular_user.id }
        it_behaves_like :delete_user_success
      end

      context 'manager user is deleted' do
        let(:id) { manager_user.id }
        it_behaves_like :delete_user_success
      end

      context 'admin user is deleted' do
        let(:id) { admin_user.id }
        it_behaves_like :pundit_not_authorized
      end
    end
  end
end
