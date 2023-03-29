# frozen_string_literal: true

require "decidim/cleaner/admin"
require "decidim/cleaner/engine"
require "decidim/cleaner/admin_engine"

module Decidim
  # This namespace holds the logic of the `Cleaner` module.
  module Cleaner
    include ActiveSupport::Configurable

    config_accessor :delete_admin_logs_after do
      365
    end

    config_accessor :delete_inactive_users_after do
      30
    end

    config_accessor :delete_inactive_users_email_after do
      365
    end
  end
end
