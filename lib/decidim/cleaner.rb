# frozen_string_literal: true

require "decidim/cleaner/admin"
require "decidim/cleaner/engine"
require "decidim/cleaner/admin_engine"

module Decidim
  # This namespace holds the logic of the `Cleaner` module.
  module Cleaner
    include ActiveSupport::Configurable

    config_accessor :delete_admin_logs_after do
      ENV.fetch("DECIDIM_CLEANER_DELETE_ADMIN_LOGS", "365").to_i
    end

    config_accessor :delete_inactive_users_after do
      ENV.fetch("DECIDIM_CLEANER_DELETE_INACTIVE_USERS", "30").to_i
    end

    config_accessor :delete_inactive_users_email_after do
      ENV.fetch("DECIDIM_CLEANER_INACTIVE_USERS_MAIL", "365").to_i
    end

    config_accessor :delete_deleted_users_data_after do
      ENV.fetch("DECIDIM_CLEANER_DELETE_DELETED_USERS_DATA", "30").to_i
    end

    config_accessor :delete_deleted_authorizations_data_after do
      ENV.fetch("DECIDIM_CLEANER_DELETE_DELETED_AUTHORIZATIONS_DATA", "30").to_i
    end
  end
end
