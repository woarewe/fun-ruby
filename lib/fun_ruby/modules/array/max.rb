# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Array
      # Returns the maximum element of the array
      #
      # @since 0.1.0
      #
      # @param array [::Array]
      #
      # @return [Object]
      #
      # @example Basics
      #   F::Modules::Array.max([1, 2, 3]) # => 3
      #   F::Modules::Array.max([]) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Array.max
      #   curried.([1, 2, 3]) # => 3
      #   curried.([]) # => nil
      def max(array = F._)
        curry_implementation(:max, array)
      end

      private

      def _max(array)
        _array(array).max
      end
    end
  end
end
