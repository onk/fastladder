require 'spec_helper'

describe Subscription do
  describe 'creation' do
    it 'update subscribers count' do
      feed = stub_model(Feed)
      expect(feed).to receive(:update_subscribers_count)

      subscription = Subscription.new
      subscription.feed = feed
      subscription.save
    end

    it 'set default value' do
      feed = stub_model(Feed)

      subscription = Subscription.new
      subscription.feed = feed
      subscription.public = nil
      subscription.save

      expect(subscription.public).to eq(false)
    end
  end

  describe 'destroy' do
    it 'update subscribers count' do
      feed = stub_model(Feed)
      subscription = Subscription.new
      subscription.feed = feed
      subscription.save

      expect(feed).to receive(:update_subscribers_count)
      subscription.destroy
    end
  end
end
