# frozen_string_literal: true

require "decidim/dev"
require "simplecov"
require "simplecov-cobertura"

if ENV["CODECOV"]
  SimpleCov.start "rails" do
    add_filter "/spec/decidim_dummy_app/"
  end

  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter if ENV["CI"]
end

ENV["ENGINE_ROOT"] = File.dirname(__dir__)

Decidim::Dev.dummy_app_path = File.expand_path(File.join("spec", "decidim_dummy_app"))

require "decidim/dev/test/base_spec_helper"
