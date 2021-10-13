# frozen_string_literal: true

require_relative "../container"

module FunRuby
  class Container
    class Define
      private_class_method :new

      def self.build(container: FunRuby.container, namespaces: [])
        raise TypeError, "namespaces: should be an array" unless namespaces.is_a?(::Array)
        raise TypeError, "container: should be an instance of #{Container.name}" unless container.is_a?(Container)

        new(container: container, namespaces: namespaces.map(&:to_s))
      end

      def initialize(container:, namespaces:)
        @container = container
        @namespaces = namespaces
      end

      def namespace(namespace, &block)
        self.class.build(container: container, namespaces: [*namespaces, namespace]).tap do |define|
          define.instance_exec(&block)
        end
      end

      def call(&block)
        instance_exec(&block)
      end

      def function(key)
        full_key = [*namespaces, key].join(NAMESPACE_SEPARATOR)
        container.define(full_key, yield)
      end
      alias_method :f, :function

      private

      attr_reader :container, :namespaces
    end
  end
end
