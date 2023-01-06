require "spec_helper"

describe Decidim::Cleaner::UserInactivityJob do
  subject { described_class }

  let!(:user) { create(:user) }

  it "enqueues job in queue 'cleaner'" do
    expect(subject.queue_name).to eq("cleaner")
  end

  it "calls the mark users service" do
    expect(Decidim::Cleaner::UserInactivityJob).to receive(:call)

    subject.perform_now
  end
end
