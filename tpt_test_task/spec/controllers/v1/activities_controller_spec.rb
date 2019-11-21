require 'rails_helper'

describe V1::ActivitiesController do
  describe 'GET index' do
    subject(:index) { get :index }
    let(:user) { create :user, :regular }

    before do
      current_user_is user
      allow(Activity::GetActivities).to receive(:call).and_return(result)
      index
    end

    context 'success' do
      let(:result) { double(success?: true, activities: 'activities'.to_json) }

      it 'return activities' do
        expect(json['activities']).to eq 'activities'
      end
    end

    context 'failure' do
      let(:result) { double(success?: false, error: 'error') }

      it 'return error' do
        expect(json['error']).to eq 'error'
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'GET show' do
    subject(:show) { get :show, params: { id: user.id } }
    let(:user) { create :user, :regular }

    before do
      current_user_is user
      allow(Activity::GetActivity).to receive(:call).and_return(result)
      show
    end

    context 'success' do
      let(:result) { double(success?: true, activity: 'activity'.to_json) }

      it 'return activity' do
        expect(json['activity']).to eq 'activity'
      end
    end

    context 'failure' do
      let(:result) { double(success?: false, error: 'error') }

      it 'return error' do
        expect(json['error']).to eq 'error'
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'POST create' do
    subject(:create_action) { post :create, params: { param: 'param' } }
    let(:user) { create :user, :regular }

    before do
      current_user_is user
      allow(Activity::CreateActivity).to receive(:call).and_return(result)
      create_action
    end

    context 'success' do
      let(:result) { double(success?: true, activity: 'activity'.to_json) }

      it 'return activity' do
        expect(json['activity']).to eq 'activity'
      end
    end

    context 'failure' do
      let(:result) { double(success?: false, error: 'error') }

      it 'return error' do
        expect(json['error']).to eq 'error'
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'PUT update' do
    subject(:update) { put :update, params: { id: activity.id } }
    let(:user) { create :user, :regular }
    let(:activity) { create :activity }

    before do
      current_user_is user
      allow(Activity::UpdateActivity).to receive(:call).and_return(result)
      update
    end

    context 'success' do
      let(:result) { double(success?: true, activity: 'activity'.to_json) }

      it 'return activity' do
        expect(json['activity']).to eq 'activity'
      end
    end

    context 'failure' do
      let(:result) { double(success?: false, error: 'error') }

      it 'return error' do
        expect(json['error']).to eq 'error'
      end
    end
  end

  # ------------------------------------------------------------------------------------------

  describe 'DELETE destroy' do
    subject(:destroy) { delete :destroy, params: { id: activity.id } }
    let(:user) { create :user, :regular }
    let(:activity) { create :activity }

    before do
      current_user_is user
      allow(Activity::DeleteActivity).to receive(:call)
      destroy
    end

    it 'return empty object' do
      expect(json).to eq({})
    end
  end
end
