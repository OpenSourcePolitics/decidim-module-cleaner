# frozen_string_literal: true

module UpdateOrganizationExtend
  def attributes
    super.merge(
      delete_admin_logs: form.delete_admin_logs,
      delete_admin_logs_after: form.delete_admin_logs_after
    )
  end
end
