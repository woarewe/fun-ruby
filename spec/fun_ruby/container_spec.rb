# frozen_string_literal: true

require_lib "fun_ruby/container"

describe FunRuby::Container do
  describe "#define" do
    it "defines a new function" do
      container = described_class.new
      function = ->(x, y) { x + y }
      key = "sum"

      container.define(key, function)

      expect(container.fetch(key)).to equal(function)
    end

    it "raises error if key is already defined" do
      container = described_class.new
      function = ->(x, y) { x + y }
      key = "sum"
      container.define(key, function)

      expect { container.define(key, function) }.to raise_error(KeyError)
    end

    it "raises error if function is not callable" do
      container = described_class.new
      function = Object.new
      key = "sum"

      expect { container.define(key, function) }.to raise_error(TypeError)
    end
  end

  describe "#fetch" do
    it "returns defined function" do
      container = described_class.new
      function = ->(x, y) { x + y }
      key = "sum"

      container.define(key, function)

      expect(container.fetch(key)).to equal(function)
    end

    it "raises error if no registered key" do
      container = described_class.new
      key = "sum"

      expect { container.fetch(key) }.to raise_error(KeyError)
    end
  end
end
