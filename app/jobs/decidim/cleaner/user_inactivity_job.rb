module Decidim
  module Cleaner
    class UserInactivityJob < ApplicationJob
      queue_as :cleaner

      def perform
        return unless Decidim::Cleaner.user_inactivity_enabled


      end
    end
  end
end
