# frozen_string_literal: true

module FunRuby
  class Container
    # The class store a configuration for a container
    class Config
      # @private
      def initialize(override: false)
        @override = override
      end

      # @private
      def can_override?
        @override
      end

      # @private
      def cant_override?
        !can_override?
      end

      private

      attr_reader :override
    end
  end
end
