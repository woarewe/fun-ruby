# frozen_string_literal: true

module FunRuby
  class Container
    class Resolve
      private_class_method :new

      def self.build(*params)
        aliases = params.each_with_object({}) do |key, namespace|
          if key.is_a?(Hash)
            namespace.merge!(key.map { |k, v| [k, v].map(&:to_s) }.to_h )
          else
            namespace[key.to_s] = nil
          end
        end
        new(aliases)
      end

      def initialize(aliases = {})
        @aliases = aliases
      end

      def call(key)
        key = key.to_s
        aliases.each do |(namespace, shortcut)|
          full_key = shortcut.nil? ? [namespace, key].join(".") : key.gsub(shortcut, namespace)
          function = try(full_key)
          return function if function
        end

        raise KeyError
      end

      private

      def try(full_key)
        container.fetch(full_key)
      rescue KeyError
        nil
      end

      def container
        @container ||= FunRuby.container
      end

      attr_reader :aliases
    end
  end
end
