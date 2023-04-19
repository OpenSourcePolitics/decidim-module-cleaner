# frozen_string_literal: true

class AddWarningDateToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_users, :warning_date, :datetime
  end
end
