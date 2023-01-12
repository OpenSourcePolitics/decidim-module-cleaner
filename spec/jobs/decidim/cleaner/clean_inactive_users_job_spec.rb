# frozen_string_literal: true

require "spec_helper"

describe Decidim::Cleaner::CleanInactiveUsersJob do
  subject { described_class }

  context "when the delay is specified" do
    let!(:organization) { create(:organization, delete_inactive_users: true, delete_inactive_users_email_after: 25, delete_inactive_users_after: 30) }
    let!(:pending_user) { create(:user, organization: organization, last_sign_in_at: 25.days.ago - 1.hour) }
    let!(:inactive_user) { create(:user, organization: organization, last_sign_in_at: 50.days.ago) }
    let!(:user) { create(:user, organization: organization) }

    it "enqueues job in queue 'cleaner'" do
      expect(subject.queue_name).to eq("scheduled")
    end

    it "send emails" do
      expect(Decidim::Cleaner::InactiveUsersMailer).to receive(:warning_inactive).with(pending_user).and_call_original
      expect(Decidim::Cleaner::InactiveUsersMailer).to receive(:warning_deletion).with(inactive_user).and_call_original

      subject.perform_now
    end

    it "delete user" do
      expect(Decidim::User.count).to eq(3)

      subject.perform_now

      expect(Decidim::User.count).to eq(2)
    end
  end
end
