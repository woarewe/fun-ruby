# frozen_string_literal: true

require_lib "fun_ruby/container"

describe FunRuby::Container do
  describe "#define" do
    it "defines a new function" do
      container = described_class.new
      function = ->(x, y) { x + y }
      key = "sum"

      container.define(key) { function }

      expect(container.fetch(key)).to equal(function)
    end

    it "raises error if key is already defined" do
      container = described_class.new
      function = ->(x, y) { x + y }
      key = "sum"
      container.define(key) { function }

      expect { container.define(key) { function } }.to raise_error(KeyError)
    end

    it "does not raise an error when overriding is allowed by config", :aggregate_failures do
      config = described_class::Config.new(override: true)
      container = described_class.new(config)
      first_definition = ->(x, y) { x + y }
      key = "sum"
      second_definition = ->(a, b) { a - b }

      container.define(key) { first_definition }

      expect { container.define(key) { second_definition } }.not_to raise_error
      expect(container.fetch(key)).to equal(second_definition)
    end
  end

  describe "#fetch" do
    it "returns defined function" do
      container = described_class.new
      function = ->(x, y) { x + y }
      key = "sum"

      container.define(key) { function }

      expect(container.fetch(key)).to equal(function)
    end

    it "raises error if no registered key" do
      container = described_class.new
      key = "sum"

      expect { container.fetch(key) }.to raise_error(KeyError)
    end
  end
end
