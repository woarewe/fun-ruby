# frozen_string_literal: true

require_lib "fun_ruby"

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

  describe "#import" do
    it "works for custom containers" do
      function = -> {}

      custom_container = described_class.new.tap do |container|
        described_class::Define.build(container: container).instance_exec do
          namespace :math do
            f(:value) { function }
          end
        end
      end

      target_class = Class.new do
        include custom_container.import

        def call
          f("math.value")
        end
      end

      expect(target_class.new.()).to equal(function)
    end
  end
end
