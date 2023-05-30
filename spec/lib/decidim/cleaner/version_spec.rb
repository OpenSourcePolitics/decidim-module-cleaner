# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Cleaner do
    subject { described_class }

    it "has version" do
      expect(subject.version).to eq("0.1.1")
    end

    it "has decidim version compatibility" do
      expect(subject.decidim_version).to eq("0.22.0.dev")
    end
  end
end
