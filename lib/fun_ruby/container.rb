# frozen_string_literal: true

require_relative "container/mixin"

module FunRuby
  # @private
  class Container
    NAMESPACE_SEPARATOR = "."

    # @private
    def self.[](*aliases)
      Mixin.build(aliases: aliases)
    end

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
      storage[key][:value] ||= meta.fetch(:definition).()
    end

    private

    attr_reader :storage, :mutex

    def init_meta(definition)
      {
        definition: definition,
        value: nil
      }
    end
  end
end
