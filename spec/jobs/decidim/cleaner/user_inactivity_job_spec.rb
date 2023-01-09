# frozen_string_literal: true

require "spec_helper"

describe Decidim::Cleaner::UserInactivityJob do
  subject { described_class }

  let!(:user) { create(:user) }

  it "enqueues job in queue 'cleaner'" do
    expect(subject.queue_name).to eq("cleaner")
  end
end
