# frozen_string_literal: true

module Decidim
  module Cleaner
    module Admin
      # A form object used to update the current organization cleaner from the admin
      # dashboard.
      #
      class OrganizationCleanerForm < Form
        mimic :organization

        attribute :delete_admin_logs, Boolean
        attribute :delete_admin_logs_after, Integer
      end
    end
  end
end
