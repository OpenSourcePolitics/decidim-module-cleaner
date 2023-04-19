# frozen_string_literal: true

require "spec_helper"

describe Decidim::Cleaner::CleanInactiveUsersJob do
  subject { described_class }

  context "when the delay is specified" do
    let!(:organization) { create(:organization, delete_inactive_users: true, delete_inactive_users_email_after: 25, delete_inactive_users_after: 5) }
    let!(:pending_user) { create(:user, organization: organization, last_sign_in_at: 27.days.ago) }
    let!(:inactive_user) { create(:user, organization: organization, last_sign_in_at: 35.days.ago, warning_date: 10.days.ago) }
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
      subject.perform_now

      expect(Decidim::User.count).to eq(3)
      expect(inactive_user.reload).to be_deleted
      expect(pending_user.reload).not_to be_deleted
      expect(user.reload).not_to be_deleted
    end

    context "when users have destroyed his/her account" do
      let!(:pending_user) { create(:user, :deleted, organization: organization, last_sign_in_at: 27.days.ago) }
      let!(:inactive_user) { create(:user, :deleted, organization: organization, last_sign_in_at: 35.days.ago, warning_date: 10.days.ago) }

      it "doesn't send email" do
        expect(Decidim::Cleaner::InactiveUsersMailer).not_to receive(:warning_inactive).with(pending_user).and_call_original
        expect(Decidim::Cleaner::InactiveUsersMailer).not_to receive(:warning_deletion).with(inactive_user).and_call_original

        subject.perform_now
      end

      it "destroy user" do
        subject.perform_now

        expect(Decidim::User.count).to eq(3)
        expect(inactive_user.reload).to be_deleted
        expect(pending_user.reload).to be_deleted
        expect(user.reload).not_to be_deleted
      end
    end

    context "when user reconnect after warning" do
      let!(:inactive_user) { create(:user, organization: organization, last_sign_in_at: 7.days.ago, warning_date: 10.days.ago) }

      it "doesn't send email" do
        expect(Decidim::Cleaner::InactiveUsersMailer).not_to receive(:warning_deletion).with(inactive_user).and_call_original

        subject.perform_now
      end

      it "doesn't destroy user" do
        subject.perform_now

        expect(inactive_user.reload).not_to be_deleted
      end

      it "reset warning date" do
        subject.perform_now

        expect(inactive_user.reload.warning_date).to be_nil
      end
    end
  end
end
