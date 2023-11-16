# frozen_string_literal: true

module Decidim
  # This holds the decidim-meetings version.
  module Cleaner
    def self.version
      "4.1.2"
    end

    COMPAT_DECIDIM_VERSION = [">= 0.26.0", "< 0.29"].freeze
  end
end