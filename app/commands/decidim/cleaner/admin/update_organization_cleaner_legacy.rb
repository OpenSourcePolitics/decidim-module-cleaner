# frozen_string_literal: true

module Decidim
  module Cleaner
    module Admin
      # A command with all the business logic for updating the current
      # organization cleaner.
      class UpdateOrganizationCleanerLegacy < Rectify::Command
        # Public: Initializes the command.
        #
        # organization - The Organization that will be updated.
        # form - A form object with the params.
        def initialize(organization, form)
          @organization = organization
          @form = form
        end

        # Executes the command. Broadcasts these events:
        #
        # - :ok when everything is valid.
        # - :invalid if the form wasn't valid and we couldn't proceed.
        #
        # Returns nothing.
        def call
          return broadcast(:invalid) if form.invalid?

          return broadcast(:ok, @organization) if update_organization

          broadcast(:invalid)
        end

        private

        attr_reader :form, :organization

        def update_organization
          @organization = Decidim.traceability.update!(
            organization,
            form.current_user,
            attributes
          )
        end

        def attributes
          {
            delete_admin_logs: form.delete_admin_logs,
            delete_admin_logs_after: form.delete_admin_logs_after,
            delete_inactive_users: form.delete_inactive_users,
            delete_inactive_users_after: form.delete_inactive_users_after,
            delete_inactive_users_email_after: form.delete_inactive_users_email_after
          }
        end
      end
    end
  end
end
