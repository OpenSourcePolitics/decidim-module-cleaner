# frozen_string_literal: true

# frozen_string_litteral: true

Decidim::Admin::Engine.routes.draw do
  resource :organization, controller: "organization" do
    resource :cleaner, only: [:edit, :update], controller: "/decidim/cleaner/admin/organization_cleaner"
  end
end
