# frozen_string_literal: true

require_relative "container/mixin"

module FunRuby
  # @private
  class Container
    NAMESPACE_SEPARATOR = "."
    NOT_EVALUATED = Object.new.freeze

    # @private
    def initialize
      @storage = {}
      @mutex = Mutex.new
    end

    # @private
    def define(key, &block)
      key = key.to_s

      raise KeyError, "#{key.inspect} is already defined" if storage.key?(key)
      raise TypeError, "block should be given" unless block_given?

      storage[key] = init_meta(block)
    end

    # @private
    def fetch(key)
      key = key.to_s
      meta = storage.fetch(key)
      value = storage[key].fetch(:value)
      return value unless value.equal?(NOT_EVALUATED)

      meta.fetch(:definition).().tap do |evaluated|
        storage[key][:value] = evaluated
      end
    end

    # @private
    def mixin(*aliases)
      Mixin.build(aliases: aliases)
    end

    private

    attr_reader :storage, :mutex

    def init_meta(definition)
      {
        definition: definition,
        value: NOT_EVALUATED
      }
    end
  end
end
