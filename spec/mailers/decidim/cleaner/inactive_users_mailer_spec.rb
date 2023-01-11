# frozen_string_literal: true

require "spec_helper"

module Decidim::Cleaner
  describe InactiveUsersMailer, type: :mailer do
    let(:user) { create(:user, :confirmed, organization:) }
    let(:organization) { create(:organization, delete_inactive_users: true) }
    let(:organization_url) { "http://www.example.com" }
    let(:decidim) { Decidim::Core::Engine.routes.url_helpers }

    describe "warning_inactive" do
      let(:mail) { described_class.warning_inactive(user) }

      it "parses the subject" do
        expect(mail.subject).to eq("Your account is inactive")
      end

      it "parses the body" do
        expect(email_body(mail)).to include("You are inactive since.")
        expect(email_body(mail)).to include("If no reaction within")
      end

      it "includes no-reply message" do
        expect(email_body(mail)).to include("This email was sent from a notification email address that cannot accept incoming email. Please do not reply to this message.")
      end
    end

    describe "warning_deletion" do
      let(:mail) { described_class.warning_deletion(user) }

      it "parses the subject" do
        expect(mail.subject).to eq("Your account has been deleted")
      end

      it "parses the body" do
        expect(email_body(mail)).to include("Your are inactive since")
        expect(email_body(mail)).to include("Your account has been deleted")
      end

      it "includes no-reply message" do
        expect(email_body(mail)).to include("This email was sent from a notification email address that cannot accept incoming email. Please do not reply to this message.")
      end
    end
  end
end
