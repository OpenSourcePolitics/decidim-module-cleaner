# frozen_string_literal: true

module Decidim
  module Cleaner
    class CleanInactiveUsersJob < ApplicationJob
      queue_as :scheduled

      def perform
        Decidim::Organization.find_each do |organization|
          next unless organization.delete_inactive_users?

          send_warning(Decidim::User.where(organization: organization)
                                    .where("last_sign_in_at < ?", Time.zone.now - (organization.delete_inactive_users_email_after || 365).days)
                                    .where("last_sign_in_at > ?", Time.zone.now - (organization.delete_inactive_users_email_after || 365).days - 1.day))
          delete_user_and_send_email(Decidim::User.where(organization: organization)
                                                  .where("last_sign_in_at < ?", Time.zone.now - (organization.delete_inactive_users_after || 390).days))
        end
      end

      def send_warning(users)
        users.find_each do |user|
          next if user.deleted?

          InactiveUsersMailer.warning_inactive(user).deliver_now
          Rails.logger.info "Inactive warning sent to #{user.email}"
        end
      end

      def delete_user_and_send_email(users)
        users.find_each do |user|
          next if user.deleted?

          InactiveUsersMailer.warning_deletion(user).deliver_now
          Rails.logger.info "Deletion warning sent to #{user.email}"

          Decidim::DestroyAccount.call(user, Decidim::DeleteAccountForm.from_params({ delete_reason: I18n.t("decidim.cleaner.delete_reason") }))
          Rails.logger.info "User with id #{user.id} destroyed"
        end
      end
    end
  end
end
