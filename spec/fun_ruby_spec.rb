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

  describe ".define" do
    it "defines for a global container where no args are passed" do
      function = ->(x) { x }

      described_class.define do
        namespace :hello do
          f(:world) { function }
        end
      end

      expect(F.container.fetch("hello.world")).to equal(function)
    end

    it "defines for a passed container", :aggregate_failures do
      container = described_class::Container.new
      function = ->(x) { x }

      described_class.define(container) do
        namespace :hello do
          f(:world) { function }
        end
      end

      expect(container.fetch("hello.world")).to equal(function)
      expect { F.container.fetch("hello.world") }.to raise_error(KeyError)
    end

    it "saves a definition path of the file where it's executed as already loaded" do
      container = described_class::Container.new
      function = ->(x) { x }

      described_class.define(container) do
        namespace :hello do
          f(:world) { function }
        end
      end

      definition_path = described_class::Container::DefinitionPath.new(
        path: __FILE__,
        loaded: true
      )

      expect(container.definition_paths.first).to eq(definition_path)
    end
  end
end
