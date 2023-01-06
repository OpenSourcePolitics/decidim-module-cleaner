# frozen_string_literal: true

require "decidim/cleaner/admin"
require "decidim/cleaner/engine"
require "decidim/cleaner/admin_engine"
require "decidim/cleaner/component"

module Decidim
  # This namespace holds the logic of the `Cleaner` module.
  module Cleaner
    include ActiveSupport::Configurable

    # user_inactivity_reminder: integer - Number of days of inactivity before suppression
    config_accessor :user_inactivity_enabled do
      true
    end

    # user_inactivity_reminder: integer - Number of days of inactivity before suppression
    config_accessor :user_inactivity_reminder do
      365
    end

    # user_inactivity_limit: integer - Number of days of inactivity before suppression
    config_accessor :user_inactivity_limit do
      390
    end
  end
end
