# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/cleaner/version"

Gem::Specification.new do |s|
  s.version = Decidim::Cleaner.version
  s.authors = ["Quentinchampenois"]
  s.email = ["26109239+Quentinchampenois@users.noreply.github.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://decidim.org"
  s.metadata = {
    "bug_tracker_uri" => "https://github.com/decidim/decidim/issues",
    "documentation_uri" => "https://docs.decidim.org/",
    "funding_uri" => "https://opencollective.com/decidim",
    "homepage_uri" => "https://decidim.org",
    "source_code_uri" => "https://github.com/decidim/decidim"
  }
  s.required_ruby_version = ">= 2.6.5"

  s.name = "decidim-cleaner"
  s.summary = "A decidim cleaner module"
  s.description = "Clean outdated data in Decidim's database."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Cleaner.version
end
