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
    def define(full_key, function)
      full_key = full_key.to_s

      mutex.synchronize do
        raise KeyError, "#{full_key.inspect} is already defined" if storage.key?(full_key)
        raise TypeError, "should respond to #call" unless function.respond_to?(:call)

        storage[full_key] = function
      end
    end

    # @private
    def fetch(full_key)
      storage.fetch(full_key.to_s)
    end

    private

    attr_reader :storage, :mutex
  end
end
