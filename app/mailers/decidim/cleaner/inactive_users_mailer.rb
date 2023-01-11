# frozen_string_literal: true

module Decidim
  module Cleaner
    # A custom mailer for Decidim so we can notify users
    # when their account was blocked
    class InactiveUsersMailer < Decidim::ApplicationMailer
      def warning_inactive(user)
        with_user(user) do
          @user = user
          @organization = user.organization
          subject = I18n.t(
            "decidim.cleaner.inactive_users_mailer.warning_inactive.subject",
            organization_name: @organization.name
          )
          mail(to: user.email, subject:)
        end
      end

      def warning_deletion(user)
        with_user(user) do
          @user = user
          @organization = user.organization
          subject = I18n.t(
            "decidim.cleaner.inactive_users_mailer.warning_deletion.subject",
            organization_name: @organization.name
          )
          mail(to: user.email, subject:)
        end
      end
    end
  end
end
