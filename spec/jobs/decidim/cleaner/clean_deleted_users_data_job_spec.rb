# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Cleaner
    describe CleanDeletedUsersDataJob do
      subject { described_class }

      context "when running the job" do
        let!(:deleted_user) { create(:user, :deleted, deleted_at: 2.years.ago) }
        let!(:user) { create(:user, :confirmed) }
        let!(:authorization) { create(:authorization, user:) }

        before do
          PaperTrail::Version.create!(item: deleted_user, event: "destroy")
          PaperTrail::Version.create!(item: user, event: "create")
          PaperTrail::Version.create!(item_type: "Decidim::Authorization", item_id: -1, created_at: 2.years.ago, event: "destroy")
          PaperTrail::Version.create!(item: authorization, event: "create")
        end

        it "enqueues job in queue 'cleaner'" do
          expect(subject.queue_name).to eq("scheduled")
        end

        it "removes the versions that should be removed" do
          expect do
            subject.perform_now
          end.to change(PaperTrail::Version, :count).from(4).to(2)

          expect(PaperTrail::Version.first.item).to eq(user)
          expect(PaperTrail::Version.last.item_type).to eq("Decidim::Authorization")
        end
      end
    end
  end
end
