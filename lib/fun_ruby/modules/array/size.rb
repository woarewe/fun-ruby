# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Array
      # Returns a size of array
      #
      # @since 0.1.0
      #
      # @param array [::Array]
      #
      # @return [Integer]
      #
      # @example Basics
      #   F::Modules::Array.size([]) # => 0
      #   F::Modules::Array.size([1]) # => 1
      #   F::Modules::Array.size([1, 2, 3]) # => 3
      #
      # @example Curried
      #   curried = F::Modules::Array.size
      #   curried.([1,2,3]) # => 3
      #   curried.([]) # => 0
      def size(array = F._)
        curry_implementation(:size, array)
      end

      private

      def _size(array)
        _array(array).size
      end
    end
  end
end
