require 'rails_helper'

describe User::GetUsers do
  describe '.call' do
    let!(:regular_users) { create_list :user, 3, :regular }
    let!(:manager_users) { create_list :user, 3, :manager }
    let!(:admin_users) { create_list :user, 3, :admin }

    subject(:service) do
      -> { @result = described_class.call(user: user) }
    end

    context 'user regular' do
      let(:user) { create :user, :regular }

      it_behaves_like :pundit_not_authorized
    end

    context 'user manager' do
      let(:user) { create :user, :manager }

      before { service.call }

      it 'success' do
        expect(@result.success?).to eq true
      end

      it 'return correct users' do
        expect(@result.users.all?(&:is_regular?)).to eq true
        expect(@result.users.count).to eq 3
      end
    end

    context 'user admin' do
      let(:user) { create :user, :admin }

      before { service.call }

      it 'success' do
        expect(@result.success?).to eq true
      end

      it 'return correct users' do
        expect(@result.users.count).to eq 6
      end
    end
  end
end
