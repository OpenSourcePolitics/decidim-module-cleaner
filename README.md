# Decidim::Cleaner

Clean outdated data in Decidim's database.

## Usage

This module provides tasks designed to cleanup the outdated data directly in database.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "decidim-cleaner"
```

And then execute:

```bash
bundle
bundle exec rails decidim_cleaner:install:migrations
bundle exec rails db:migrate
```

### Sidekiq Scheduler
[Further documentation](https://github.com/sidekiq-scheduler/sidekiq-scheduler)

**Sidekiq scheduler uses a 6 columns format**

You can then add to your 'config/sidekiq.yml' file:

```yaml
:schedule:
  CleanAdminLogs:
    cron: "0 9 0 * * *"
    class: Decidim::Cleaner::CleanAdminLogsJob
    queue: scheduled
  CleanInactiveUsers:
    cron: "0 9 0 * * *"
    class: Decidim::Cleaner::CleanInactiveUsersJob
    queue: scheduled
```

### Cronjob
```
# Warns and deletes inactive users
0 9 * * * cd /home/user/decidim_application && RAILS_ENV=production bundle exec rake decidim_cleaner:clean_inactive_users

# Deletes old admin logs
0 9 * * * cd /home/user/decidim_application && RAILS_ENV=production bundle exec rake decidim_cleaner:clean_admin_logs
```

## Available tasks

- [ ] **Delete inactive users**
  - Cron task that checks for user accounts where `last_sign_in_at` is superior to environment variable `CLEANER_USER_INACTIVITY_LIMIT`. If true, deletes inactive user from the database.

- [ ] **Delete old admin logs**
  - Cron task that checks for admin logs where `created_at` is anterior to the time you configured in the back office. If true, deletes old admin logs from the database.

## Contributing

Contributions are welcome !

We expect the contributions to follow the [Decidim's contribution guide](https://github.com/decidim/decidim/blob/develop/CONTRIBUTING.adoc).

## Security

Security is very important to us. If you have any issue regarding security, please disclose the information responsibly by sending an email to __security [at] opensourcepolitics [dot] eu__ and not by creating a Github issue.

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.
