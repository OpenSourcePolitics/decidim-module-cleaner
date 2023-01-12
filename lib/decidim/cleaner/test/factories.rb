# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :cleaner_component, parent: :component do
    name { Decidim::Components::Namer.new(participatory_space.organization.available_locales, :cleaner).i18n_name }
    manifest_name :cleaner
    participatory_space { create(:participatory_process, :with_steps) }
  end
end
