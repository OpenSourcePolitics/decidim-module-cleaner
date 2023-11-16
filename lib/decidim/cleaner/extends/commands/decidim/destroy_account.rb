# frozen_string_literal: true

module Decidim
  module Cleaner
    module Extends
      # This command destroys the user's account.
      module DestroyAccount
        extend ActiveSupport::Concern

        included do
          private

          # Invalidate all sessions after cleaning Decidim::User record to prevent Active Record error
          def destroy_user_account!
            @user.name = ""
            @user.nickname = ""
            @user.email = ""
            @user.delete_reason = @form.delete_reason
            @user.admin = false if @user.admin?
            @user.deleted_at = Time.current
            @user.skip_reconfirmation!
            @user.avatar.purge
            @user.save!

            @user.invalidate_all_sessions!
          end
        end
      end
    end
  end
end
