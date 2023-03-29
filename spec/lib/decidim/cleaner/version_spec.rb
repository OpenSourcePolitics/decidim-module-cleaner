# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Cleaner do
    subject { described_class }

    it "has version" do
      expect(subject.version).to eq("4.0.0")
    end

    it "has decidim version compatibility" do
      expect(subject.compatible_decidim_version).to eq("0.28.dev")
    end
  end
end
