# frozen_string_literal: true

module Decidim
  module Cleaner
    class CleanAdminLogsJob < ApplicationJob
      queue_as :scheduled

      def perform
        Decidim::Organization.find_each do |organization|
          next unless organization.delete_admin_logs?

          Decidim::ActionLog.where(organization:).where("created_at < ?", Time.zone.now - (organization.delete_admin_logs_after || 365).days).delete_all
        end
      end
    end
  end
end
