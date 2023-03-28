# frozen_string_literal: true

module Decidim
  module Cleaner
    module Admin
      # Controller that allows managing the appearance of the organization.
      class OrganizationCleanerController < Decidim::Admin::ApplicationController
        include Decidim::Admin::Engine.routes.url_helpers
        layout "decidim/admin/settings"

        def edit
          enforce_permission_to :update, :organization, organization: current_organization
          @form = form(OrganizationCleanerForm).from_model(current_organization)
        end

        def update
          enforce_permission_to :update, :organization, organization: current_organization
          @form = form(OrganizationCleanerForm).from_params(params)

          Decidim::Cleaner::LegacyHelper.update_organization_cleaner_command.call(current_organization, @form) do
            on(:ok) do
              flash[:notice] = I18n.t("organization.update.success", scope: "decidim.admin")

              redirect_to Decidim::Admin::Engine.routes.url_helpers.edit_organization_cleaner_path
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("organization.update.error", scope: "decidim.admin")
              render :edit
            end
          end
        end
      end
    end
  end
end
