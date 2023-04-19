# frozen_string_literal: true

module Decidim
  module Cleaner
    class CleanAdminLogsJob < ApplicationJob
      queue_as :scheduled

      def perform
        Decidim::Organization.find_each do |organization|
          next unless organization.delete_admin_logs?

          Decidim::ActionLog.where(organization: organization)
                            .where("created_at < ?", delete_admin_logs_before_date(organization))
                            .delete_all
        end
      end

      private

      def delete_admin_logs_before_date(organization)
        Time.zone.now - (organization.delete_admin_logs_after || Decidim::Cleaner.delete_admin_logs_after).days
      end
    end
  end
end
