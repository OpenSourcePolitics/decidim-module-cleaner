# frozen_string_literal: true

module Decidim
  module Cleaner
    # This is the engine that runs on the public interface of `Cleaner`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Cleaner::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      initializer "decidim_admin.admin_settings_menu" do
        Decidim.menu :admin_settings_menu do |menu|
          menu.item I18n.t("menu.clean", scope: "decidim.admin"),
                    decidim_admin.edit_organization_cleaner_path,
                    position: 9,
                    if: allowed_to?(:update, :organization, organization: current_organization),
                    active: is_active_link?(decidim_admin.edit_organization_cleaner_path)
        end
      end

      def load_seed
        nil
      end
    end
  end
end
