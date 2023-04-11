# frozen_string_literal: true

module Decidim
  module Cleaner
    module DelaysHelper
      def email_inactive_after(organization)
        organization.delete_inactive_users_email_after || Decidim::Cleaner.delete_inactive_users_email_after
      end

      def delete_inactive_after(organization)
        organization.delete_inactive_users_after || Decidim::Cleaner.delete_inactive_users_after
      end
    end
  end
end
