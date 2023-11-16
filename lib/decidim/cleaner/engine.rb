# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Cleaner
    # This is the engine that runs on the public interface of cleaner.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Cleaner

      config.to_prepare do
        Decidim::DestroyAccount.include(Decidim::Cleaner::Extends::DestroyAccount)
      end
    end
  end
end
