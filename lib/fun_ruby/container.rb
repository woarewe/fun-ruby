# frozen_string_literal: true

require_relative "container/mixin"
require_relative "container/config"
require_relative "container/definition_path"

module FunRuby
  # @private
  class Container
    NAMESPACE_SEPARATOR = "."
    NOT_EVALUATED = Object.new.freeze

    # Returns a list of files with definitions for the container
    attr_reader :definition_paths

    # @private
    def initialize(config = Config.new)
      @storage = {}
      @mutex = Mutex.new
      @config = config
      @definition_paths = Set.new
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

    # Adds a path to the definition path lit
    def add_definition_path(path, loaded = false)
      path = DefinitionPath.new(path: path, loaded: loaded)
      # TODO: Add file existence validations and etc.
      @definition_paths.add(path)
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
