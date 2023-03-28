# frozen_string_literal: true

require "decidim/cleaner/admin"
require "decidim/cleaner/engine"
require "decidim/cleaner/admin_engine"

module Decidim
  # This namespace holds the logic of the `Cleaner` module.
  module Cleaner
    autoload :LegacyHelper, "decidim/cleaner/legacy_helper"
  end
end
