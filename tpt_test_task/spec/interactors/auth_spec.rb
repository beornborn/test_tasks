require 'rails_helper'

describe Auth do
  let(:secret) { '2493e52af1349fd9ca2a340296819f8b512c7ee6156d688771ca09f535ddc5fcc5966bacee87b9134afcaf078ffec0c08b4af2dc186d7124f259c7e1f55733cf' }
  before { stub_env('rails_secret', secret)}

  let(:params) do
    { id: 4 }
  end

  describe '.issue' do
    subject(:issue) do
      described_class.issue(params)
    end

    it 'return correct token' do
      token = issue
      expect(token).to be_present
      id = described_class.decode(token).first['id']
      expect(id).to eq params[:id]
    end
  end

  describe '.decode' do
    subject(:decode) do
      described_class.decode(token)
    end

    context 'valid token' do
      let(:token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NH0.hmXro5wMnn7K2Jqc0MNv7S54t1toP1m-mUjRAlM2kDE' }

      it 'return decoded payload' do
        expect(decode.first['id']).to eq 4
      end
    end

    context 'invalid token' do
      let(:token) { '1' }

      it 'raise error' do
        expect { decode }.to raise_error InvalidTokenError
      end
    end
  end
end
