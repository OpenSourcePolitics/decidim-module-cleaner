# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Cleaner do
    subject { described_class }

    it "has version" do
      expect(subject.version).to eq("1.0.1")
    end

    it "has decidim version compatibility" do
      expect(subject.minimum_decidim_version).to eq("0.26.0")
      expect(subject.maximum_decidim_version).to eq("0.28.0")
    end
  end
end
