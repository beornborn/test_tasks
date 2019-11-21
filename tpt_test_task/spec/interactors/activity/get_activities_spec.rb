require 'rails_helper'

describe Activity::GetActivities do
  describe '.call' do
    let!(:regular) { create :user, :regular }
    let!(:manager) { create :user, :manager }
    let!(:admin) { create :user, :admin }

    let!(:regular_activity) { create :activity, user: regular }
    let!(:manager_activity) { create :activity, user: manager }
    let!(:admin_activity) { create :activity, user: admin }
    let!(:user_activity) { create :activity, user: user }

    subject(:service) do
      -> { @result = described_class.call(user: user) }
    end

    before { service.call }

    context 'user regular' do
      let(:user) { create :user, :regular }

      it 'return correct set of activites' do
        expect(@result.success?).to eq true
        expect(@result.activities.size).to eq 1
        expect(@result.activities.first).to eq user_activity
      end
    end

    context 'user manager' do
      let(:user) { create :user, :manager }

      it 'return correct set of activites' do
        expect(@result.success?).to eq true
        expect(@result.activities.size).to eq 1
        expect(@result.activities.first).to eq user_activity
      end
    end

    context 'user admin' do
      let(:user) { create :user, :admin }

      it 'return correct set of activites' do
        expect(@result.success?).to eq true
        expect(@result.activities.size).to eq 3
        expect(@result.activities.map(&:id)).to match_array([user_activity.id, regular_activity.id, manager_activity.id])
      end
    end
  end
end
