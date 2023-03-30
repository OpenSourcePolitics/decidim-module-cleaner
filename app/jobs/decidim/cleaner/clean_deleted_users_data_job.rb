# frozen_string_literal: true

module Decidim
  module Cleaner
    class CleanDeletedUsersDataJob < ApplicationJob
      queue_as :scheduled

      def perform
        PaperTrail::Version.joins(
          <<~SQL.squish
            INNER JOIN decidim_users ON decidim_users.id = versions.item_id
              AND versions.item_type IN ('Decidim::User', 'Decidim::UserBaseEntity')
          SQL
        ).where("deleted_at < ?", 1.day.ago).each do |version|
          version.destroy!
          Rails.logger.info "Version for user with id #{version.item_id} destroyed"
        end
      end


    end
  end
end

