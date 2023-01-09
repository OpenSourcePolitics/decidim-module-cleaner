require "spec_helper"

describe Decidim::Cleaner::CleanAdminLogsJob do
  subject { described_class }

  let!(:organization) { create(:organization, delete_admin_logs: true, delete_admin_logs_after: 1.year.ago) }
  let!(:old_action_log) { create(:action_log, organization: organization, created_at: 2.years.ago) }
  let!(:action_log) { create(:action_log, organization: organization) }

  it "enqueues job in queue 'cleaner'" do
    expect(subject.queue_name).to eq("scheduled")
  end

  it "removes the admin logs that should be removed" do
    expect(Decidim::ActionLog.count).to eq(2)

    subject.perform_now

    expect(Decidim::ActionLog.count).to eq(1)
    expect(Decidim::ActionLog.first).to eq(action_log)
  end
end
