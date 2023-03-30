# frozen_string_literal: true

# :nocov:
namespace :decidim_cleaner do
  desc "Warns and deletes inactive users"
  task clean_inactive_users: :environment do
    Decidim::Cleaner::CleanInactiveUsersJob.perform_now
  end

  desc "Deletes old admin logs"
  task clean_admin_logs: :environment do
    Decidim::Cleaner::CleanAdminLogsJob.perform_now
  end

  desc "Deletes versions for deleted users"
  task clean_deleted_users_data: :environment do
    Decidim::Cleaner::CleanDeletedUsersDataJob.perform_now
  end
end
# :nocov:
