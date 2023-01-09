module Decidim
  module Cleaner
    class CleanAdminLogsJob < ApplicationJob
      queue_as :scheduled

      def perform
        Decidim::Organization.find_each do |organization|
          return unless organization.delete_admin_logs?

          Decidim::AdminLog.where(organization:).where("created_at < ?", organization.delete_admin_logs_after).delete_all
        end
      end
    end
  end
end
