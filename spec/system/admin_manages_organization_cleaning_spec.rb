# frozen_string_literal: true

require "spec_helper"

describe "Admin manages organization cleaning", type: :system do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :admin, :confirmed, organization:) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  describe "edit" do
    it "updates the values from the form" do
      visit decidim_admin.edit_organization_cleaner_path

      expect(page).to have_content("Enable admin logs deletion")
      expect(page).to have_content("Delete admin logs after")

      find(:css, "input[name='organization[delete_admin_logs]'").set(true)
      fill_in "Delete admin logs after", with: 365

      click_button "Update"
      expect(page).to have_content("updated successfully")
    end
  end
end
