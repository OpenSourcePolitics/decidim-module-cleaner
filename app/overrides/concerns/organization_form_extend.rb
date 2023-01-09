# frozen_string_literal: true

module OrganizationFormExtend
  extend ActiveSupport::Concern

  included do |base|
    attribute :delete_admin_logs, base::Boolean
    attribute :delete_admin_logs_after, Integer

    validates :delete_admin_logs_after, presence: true, if: :delete_admin_logs
  end
end
