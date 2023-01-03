# frozen_string_literal: true

module Decidim
  module Cleaner
    # This is the engine that runs on the public interface of `Cleaner`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Cleaner::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :cleaner do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "cleaner#index"
      end

      def load_seed
        nil
      end
    end
  end
end
