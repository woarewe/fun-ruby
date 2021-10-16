# frozen_string_literal: true
require_relative "container/mixin"

module FunRuby
  # @private
  class Container
    NAMESPACE_SEPARATOR = "."

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

      # mutex.synchronize do
        raise KeyError, "#{key.inspect} is already defined" if storage.key?(key)
        raise TypeError, "block should be given" unless block_given?

        storage[key] = init_meta(block)
      # end
    end

    # @private
    def fetch(key)
      key = key.to_s
      # mutex.synchronize do
        meta = storage.fetch(key)
        storage[key][:value] ||= meta.fetch(:definition).()
      # end
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
