# frozen_string_literal: true

require_relative "container/mixin"
require_relative "container/config"

module FunRuby
  # @private
  class Container
    NAMESPACE_SEPARATOR = "."
    NOT_EVALUATED = Object.new.freeze

    # @private
    def initialize(config = Config.new)
      @storage = {}
      @mutex = Mutex.new
      @config = config
    end

    # @private
    def define(key, &block)
      key = key.to_s

      raise KeyError, "#{key.inspect} is already defined" if storage.key?(key) && config.cant_override?
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
    def import(*aliases)
      Mixin.build(aliases: aliases)
    end

    private

    attr_reader :storage, :mutex, :config

    def init_meta(definition)
      {
        definition: definition,
        value: NOT_EVALUATED
      }
    end
  end
end
