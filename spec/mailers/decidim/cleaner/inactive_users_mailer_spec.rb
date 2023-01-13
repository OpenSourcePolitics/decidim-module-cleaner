# frozen_string_literal: true

require "spec_helper"

module Decidim::Cleaner
  describe InactiveUsersMailer, type: :mailer do
    let(:user) { create(:user, :confirmed, organization: organization) }
    let(:organization) { create(:organization, delete_inactive_users: true) }
    let(:organization_url) { "http://www.example.com" }
    let(:decidim) { Decidim::Core::Engine.routes.url_helpers }

    describe "warning_inactive" do
      let(:mail) { described_class.warning_inactive(user) }

      it "parses the subject" do
        expect(mail.subject).to eq("Your account is inactive")
      end

      it "parses the body" do
        expect(email_body(mail)).to include("You are inactive since")
        expect(email_body(mail)).to include("If no reaction within")
      end
    end

    describe "warning_deletion" do
      let(:mail) { described_class.warning_deletion(user) }

      it "parses the subject" do
        expect(mail.subject).to eq("Your account has been deleted")
      end

      it "parses the body" do
        expect(email_body(mail)).to include("You are inactive since")
        expect(email_body(mail)).to include("your account has been deleted")
      end
    end
  end
end
