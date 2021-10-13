# frozen_string_literal: true

module FunRuby
  class Container
    class Resolve
      private_class_method :new

      def self.build(aliases: [], container: FunRuby.container)
        aliases = aliases.each_with_object({}) do |key, namespace|
          if key.is_a?(Hash)
            namespace.merge!(key.map { |k, v| [k, v].map(&:to_s) }.to_h )
          else
            namespace[key.to_s] = nil
          end
        end
        new(aliases: aliases, container: container)
      end

      def initialize(aliases:, container:)
        @aliases = aliases
        @container = container
      end

      def call(key)
        key = key.to_s
        aliases.each do |(namespace, shortcut)|
          full_key = shortcut.nil? ? [namespace, key].join(NAMESPACE_SEPARATOR) : key.gsub(shortcut, namespace)
          function = try(full_key)
          return function if function
        end

        raise KeyError, "key #{key.inspect} has not been registered"
      end

      private

      def try(full_key)
        container.fetch(full_key)
      rescue KeyError
        nil
      end

      attr_reader :aliases, :container
    end
  end
end
