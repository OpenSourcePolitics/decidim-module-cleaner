# frozen_string_literal: true

class AddDeleteAdminLogsToOrganization < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_organizations, :delete_admin_logs, :boolean, default: false, null: false
    add_column :decidim_organizations, :delete_admin_logs_after, :integer
  end
end
