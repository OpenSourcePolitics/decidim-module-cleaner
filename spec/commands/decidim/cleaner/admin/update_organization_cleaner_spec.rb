# frozen_string_literal: true

require "spec_helper"

module Decidim::Cleaner::Admin
  describe UpdateOrganizationCleaner do
    describe "call" do
      let(:organization) { create(:organization) }
      let(:user) { create(:user, organization: organization) }
      let(:params) do
        {
          delete_admin_logs: true,
          delete_admin_logs_after: 25,
          delete_inactive_users: true,
          delete_inactive_users_after: 30,
          delete_inactive_users_email_after: 25
        }
      end
      let(:context) do
        {
          current_user: user,
          current_organization: organization
        }
      end
      let(:form) do
        OrganizationCleanerForm.from_params(params).with_context(context)
      end
      let(:command) { described_class.new(organization, form) }

      describe "when the form is not valid" do
        before do
          allow(form).to receive(:invalid?).and_return(true)
        end

        it "broadcasts invalid" do
          expect { command.call }.to broadcast(:invalid)
        end

        it "doesn't update the organization" do
          command.call
          organization.reload

          expect(organization.delete_admin_logs).to be false
          expect(organization.delete_admin_logs_after).to be_nil
          expect(organization.delete_inactive_users).to be false
          expect(organization.delete_inactive_users_after).to be_nil
          expect(organization.delete_inactive_users_email_after).to be_nil
        end
      end

      describe "when the form is valid" do
        it "broadcasts ok" do
          expect { command.call }.to broadcast(:ok)
        end

        it "traces the update", versioning: true do
          expect(Decidim.traceability)
            .to receive(:update!)
            .with(organization, user, a_kind_of(Hash))
            .and_call_original

          expect { command.call }.to change(Decidim::ActionLog, :count)

          action_log = Decidim::ActionLog.last
          expect(action_log.version).to be_present
          expect(action_log.version.event).to eq "update"
        end

        it "updates the organization in the organization" do
          expect { command.call }.to broadcast(:ok)
          organization.reload

          expect(organization.delete_admin_logs).to be true
          expect(organization.delete_admin_logs_after).to eq(25)
          expect(organization.delete_inactive_users).to be true
          expect(organization.delete_inactive_users_after).to eq(30)
          expect(organization.delete_inactive_users_email_after).to eq(25)
        end
      end
    end
  end
end
