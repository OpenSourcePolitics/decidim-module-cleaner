# frozen_string_literal: true

module Decidim
  module Cleaner
    class CleanInactiveUsersJob < ApplicationJob
      queue_as :scheduled

      def perform
        Decidim::Organization.find_each do |organization|
          next unless organization.delete_inactive_users?

          send_warning(Decidim::User.where(organization: organization)
                                    .not_deleted
                                    .where.not(email: "")
                                    .where("last_sign_in_at < ?", email_inactive_before_date(organization)))
          delete_user_and_send_email(Decidim::User.where(organization: organization)
                                                  .not_deleted
                                                  .where.not(email: "")
                                                  .where("warning_date < ?", delete_inactive_before_date(organization)))
        end
      end

      def send_warning(users)
        users.find_each do |user|
          next if user.warning_date.present?

          user.update!(warning_date: Time.zone.now) if InactiveUsersMailer.warning_inactive(user).deliver_now
          Rails.logger.info "Inactive warning sent to #{user.email}"
        end
      end

      def delete_user_and_send_email(users)
        users.find_each do |user|
          if user.last_sign_in_at > user.warning_date
            user.update!(warning_date: nil)
            Rails.logger.info "User with id #{user.id} has logged in again, warning date reset"
            next
          end

          InactiveUsersMailer.warning_deletion(user).deliver_now
          Rails.logger.info "Deletion warning sent to #{user.email}"

          Decidim::DestroyAccount.call(user, Decidim::DeleteAccountForm.from_params({ delete_reason: I18n.t("decidim.cleaner.delete_reason") }))
          Rails.logger.info "User with id #{user.id} destroyed"
        end
      end

      private

      def email_inactive_before_date(organization)
        Time.zone.now - (organization.delete_inactive_users_email_after || Decidim::Cleaner.delete_inactive_users_email_after).days
      end

      def delete_inactive_before_date(organization)
        Time.zone.now - (organization.delete_inactive_users_after || Decidim::Cleaner.delete_inactive_users_after).days
      end
    end
  end
end
