# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Array
      # Returns the minimum element of the array
      #
      # @since 0.1.0
      #
      # @param array [::Array]
      #
      # @return [Object]
      #
      # @example Basics
      #   F::Modules::Array.min([3, 2, 1]) # => 1
      #   F::Modules::Array.min([]) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Array.min
      #   curried.([3, 2, 1]) # => 1
      #   curried.([]) # => nil
      def min(array = F._)
        curry_implementation(:min, array)
      end

      private

      def _min(array)
        _array(array).min
      end
    end
  end
end
