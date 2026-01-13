# frozen_string_literal: true

require "decidim/cleaner/test/factories"

FactoryBot.modify do
  factory :organization, class: "Decidim::Organization" do
    transient do
      skip_injection { false }
      create_static_pages { true }
    end

    # we do not want machine translation here
    name do
      Decidim.available_locales.index_with { |_locale| Faker::Company.unique.name }
    end

    reference_prefix { Faker::Name.suffix }
    time_zone { "UTC" }
    twitter_handler { Faker::Hipster.word }
    facebook_handler { Faker::Hipster.word }
    instagram_handler { Faker::Hipster.word }
    youtube_handler { Faker::Hipster.word }
    github_handler { Faker::Hipster.word }
    sequence(:host) { |n| "#{n}.lvh.me" }
    description { generate_localized_description(:organization_description, skip_injection:) }
    favicon { Decidim::Dev.test_file("icon.png", "image/png") }
    default_locale { Decidim.default_locale }
    available_locales { Decidim.available_locales }
    users_registration_mode { :enabled }
    official_img_footer { Decidim::Dev.test_file("avatar.jpg", "image/jpeg") }
    official_url { Faker::Internet.url }
    enable_omnipresent_banner { false }
    badges_enabled { true }
    send_welcome_notification { true }
    comments_max_length { 1000 }
    admin_terms_of_service_body { generate_localized_description(:admin_terms_of_service_body, skip_injection:) }
    force_users_to_authenticate_before_access_organization { false }
    machine_translation_display_priority { "original" }
    external_domain_allowlist { ["example.org", "twitter.com", "facebook.com", "youtube.com", "github.com", "mytesturl.me"] }
    smtp_settings do
      {
        "from" => "test@example.org",
        "user_name" => "test",
        "encrypted_password" => Decidim::AttributeEncryptor.encrypt("demo"),
        "port" => "25",
        "address" => "smtp.example.org"
      }
    end
    file_upload_settings { Decidim::OrganizationSettings.default(:upload) }
    enable_participatory_space_filters { true }
    content_security_policy do
      {
        "default-src" => "localhost:* #{host}:*",
        "script-src" => "localhost:* #{host}:*",
        "style-src" => "localhost:* #{host}:*",
        "img-src" => "localhost:* #{host}:*",
        "font-src" => "localhost:* #{host}:*",
        "connect-src" => "localhost:* #{host}:*",
        "frame-src" => "localhost:* #{host}:* www.example.org",
        "media-src" => "localhost:* #{host}:*"
      }
    end
    colors do
      {
        primary: "#e02d2d",
        secondary: "#155abf",
        tertiary: "#ebc34b"
      }
    end

    delete_admin_logs { false }
    delete_inactive_users { false }

    trait :secure_context do
      host { "localhost" }
    end

    after(:create) do |organization, evaluator|
      if evaluator.create_static_pages
        tos_page = Decidim::StaticPage.find_by(slug: "terms-of-service", organization:)
        create(:static_page, :tos, organization:, skip_injection: evaluator.skip_injection) if tos_page.nil?
      end
    end
  end
end
