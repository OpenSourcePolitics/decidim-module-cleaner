# frozen_string_literal: true

require "spec_helper"

describe Decidim::Cleaner::LegacyHelper do
  subject { described_class }

  describe ".rectify_legacy?" do
    it "returns legacy status" do
      expect(subject.rectify_legacy?).to eq((defined?(Decidim::Command).nil?))
    end
  end
end
