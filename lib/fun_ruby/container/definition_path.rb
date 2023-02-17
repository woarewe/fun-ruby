# frozen_string_literal: true

module FunRuby
  class Container
    # The class stores info about a container's definition path and its state
    class DefinitionPath
      # @private
      attr_reader :path
      # @private
      def initialize(path:, loaded:)
        @path = path
        @loaded = loaded
      end

      # @private
      def eql?(other)
        path == other.path
      end

      # @private
      def ==(other)
        eql?(other) && loaded? == other.loaded?
      end

      # @private
      def hash
        path.hash
      end

      # @private
      def loaded?
        loaded
      end

      private

      attr_reader :loaded
    end
  end
end
