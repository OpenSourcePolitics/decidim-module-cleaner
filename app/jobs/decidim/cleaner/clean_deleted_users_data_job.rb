# frozen_string_literal: true

module Decidim
  module Cleaner
    class CleanDeletedUsersDataJob < ApplicationJob
      queue_as :scheduled

      def perform
        remove_versions_for_deleted_users
        remove_versions_for_deleted_authorizations
      end

      private

      def remove_versions_for_deleted_users
        PaperTrail::Version.joins(
          <<~SQL.squish
            INNER JOIN decidim_users ON decidim_users.id = versions.item_id
              AND versions.item_type IN ('Decidim::User', 'Decidim::UserBaseEntity')
        SQL
        ).where("deleted_at < ?", date_before_delete_user_versions).each do |version|
          version.destroy!
          Rails.logger.info "Version for user with id #{version.item_id} destroyed"
        end
      end

      def remove_versions_for_deleted_authorizations
        PaperTrail::Version.joins(
          <<~SQL.squish
            LEFT JOIN decidim_authorizations ON decidim_authorizations.id = versions.item_id
              AND versions.item_type = 'Decidim::Authorization'
          SQL
        ).where(item_type: "Decidim::Authorization", decidim_authorizations: { id: nil })
                           .where("versions.created_at < ?", date_before_delete_authorization_versions)
                           .each do |version|
          version.destroy!
          Rails.logger.info "Version for authorization with id #{version.item_id} destroyed"
        end
      end

      def date_before_delete_user_versions
        Decidim::Cleaner.delete_deleted_users_data_after.days.ago
      end

      def date_before_delete_authorization_versions
        Decidim::Cleaner.delete_deleted_authorizations_data_after.days.ago
      end
    end
  end
end
