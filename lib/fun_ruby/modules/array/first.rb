# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Array
      # Returns the first element of the array
      #
      # @since 0.1.0
      #
      # @param array [::Array]
      #
      # @return [Object]
      #
      # @example Basics
      #   F::Modules::Array.first([1, 2, 3]) # => 1
      #   F::Modules::Array.first([]) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Array.first
      #   curried.([1,2,3]) # => 1
      #   curried.([]) # => nil
      def first(array = F._)
        curry_implementation(:first, array)
      end

      private

      def _first(array)
        _array(array).first
      end
    end
  end
end
