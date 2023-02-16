# frozen_string_literal: true

require_relative "../lib/fun_ruby"

describe FunRuby do
  before do
    described_class.remove_instance_variable(:@container) if described_class.instance_variable_defined?(:@container)
  end

  describe ".container=" do
    it "sets the passed container as global" do
      container = described_class::Container.new

      described_class.container = container

      expect(described_class.container).to equal(container)
    end

    it "does not allow settings a global container twice" do
      container = described_class::Container.new

      described_class.container = container

      expect { described_class.container = container }.to raise_error(ArgumentError)
    end
  end
end
