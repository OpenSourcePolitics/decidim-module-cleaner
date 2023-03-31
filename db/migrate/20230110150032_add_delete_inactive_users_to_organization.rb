# frozen_string_literal: true

class AddDeleteInactiveUsersToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_organizations, :delete_inactive_users, :boolean, default: false, null: false
    add_column :decidim_organizations, :delete_inactive_users_email_after, :integer
    add_column :decidim_organizations, :delete_inactive_users_after, :integer
  end
end
