# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Array
      # Returns the last element of the array
      #
      # @since 0.1.0
      #
      # @param array [::Array]
      #
      # @return [Object]
      #
      # @example Basics
      #   F::Modules::Array.last([1, 2, 3]) # => 3
      #   F::Modules::Array.last([]) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Array.last
      #   curried.([1,2,3]) # => 3
      #   curried.([]) # => nil
      def last(array = F._)
        curry_implementation(:last, array)
      end

      private

      def _last(array)
        _array(array).last
      end
    end
  end
end
