# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Cleaner do
    subject { described_class }

    it "has user inactivity limit" do
      expect(subject.user_inactivity_limit).to eq(390)
    end
  end
end
