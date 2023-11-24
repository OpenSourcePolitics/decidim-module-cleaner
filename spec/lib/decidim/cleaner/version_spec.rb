# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Cleaner do
    subject { described_class }

    it "has version" do
      expect(subject.version).to eq("2.1.2")
    end

    it "has decidim version compatibility" do
      expect(subject.compatible_decidim_version).to eq("0.26.0")
    end
  end
end
