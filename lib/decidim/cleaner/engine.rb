# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Cleaner
    # This is the engine that runs on the public interface of cleaner.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Cleaner

      routes do
        # Add engine routes here
        # resources :cleaner
        # root to: "cleaner#index"
      end

      initializer "Cleaner.webpacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end
    end
  end
end
