# frozen_string_literal: true

module FunRuby
  class Container
    # @private
    class Resolve
      private_class_method :new

      # @private
      def self.build(aliases: [], container:)
        formatted = aliases.each_with_object({}) do |key, namespace|
          if key.is_a?(::Hash)
            namespace.merge!(key.map { |k, v| [k, v].map(&:to_s) }.to_h)
          else
            namespace[key.to_s] = nil
          end
        end
        new(aliases: formatted.to_a.reverse.to_h, container: container)
      end

      # @private
      def initialize(aliases:, container:)
        @aliases = aliases
        @container = container
      end

      # @private
      def call(key)
        key = key.to_s
        aliases.each do |(namespace, shortcut)|
          full_key = build_full_key(namespace, shortcut, key)
          begin
            return container.fetch(full_key)
          rescue KeyError
            next
          end
        end

        container.fetch(key) do
          raise KeyError, "key #{key.inspect} has not been registered"
        end
      end

      private

      def build_full_key(namespace, shortcut, key)
        if shortcut.nil?
          [namespace, key].join(NAMESPACE_SEPARATOR)
        else
          key.gsub(/(?<=\A|\.)#{shortcut}(?=\z|\.)/, namespace)
        end
      end

      attr_reader :aliases, :container
    end
  end
end
