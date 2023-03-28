# frozen_string_literal: true

module Decidim
  module Cleaner
    module LegacyHelper
      def self.update_organization_cleaner_command
        if rectify_legacy?
          Decidim::Cleaner::Admin::UpdateOrganizationCleanerLegacy
        else
          Decidim::Cleaner::Admin::UpdateOrganizationCleaner
        end
      end

      def self.factories_path
        if organization_legacy?
          "decidim/cleaner/test/factories_legacy"
        else
          "decidim/cleaner/test/factories"
        end
      end

      def self.rectify_legacy?
        defined?(Decidim::Command).nil?
      end

      def self.organization_legacy?
        Decidim::Organization.column_names.include?("admin_terms_of_use_body")
      end
    end
  end
end
