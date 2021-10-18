# frozen_string_literal: true

require_relative "../container"
require_relative "../container/resolve"

module FunRuby
  class Container
    class Define
      private_class_method :new

      # @private
      def self.build(container: FunRuby.container, namespaces: [])
        raise TypeError, "namespaces: should be an array" unless namespaces.is_a?(::Array)
        raise TypeError, "container: should be an instance of #{Container.name}" unless container.is_a?(Container)

        namespaces = namespaces.map(&:to_s)
        resolve = Resolve.build(
          container: container,
          aliases: (0...namespaces.size).reduce([]) do |combos, index|
            [namespaces[0..index].join(NAMESPACE_SEPARATOR), *combos]
          end
        )
        new(
          container: container,
          namespaces: namespaces,
          resolve: resolve
        )
      end

      # @private
      def initialize(container:, namespaces:, resolve:)
        @container = container
        @namespaces = namespaces
        @resolve = resolve
      end

      # @private
      def namespace(namespace, &block)
        self.class.build(container: container, namespaces: [*namespaces, namespace]).tap do |define|
          define.instance_exec(&block)
        end
      end

      # @private
      def call(&block)
        instance_exec(&block)
      end

      # @private
      def function(key, &block)
        if block.nil?
          resolve.(key)
        else
          full_key = [*namespaces, key].join(NAMESPACE_SEPARATOR)
          container.define(full_key, &block)
        end
      end
      alias_method :f, :function

      private

      attr_reader :container, :namespaces, :resolve
    end
  end
end
