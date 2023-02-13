# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Enum
      # Returns the minimum element of the enumerable
      #
      # @since 0.1.0
      #
      # @param enumerable [#to_enum]
      #
      # @return [Object]
      #
      # @example Basics
      #   F::Modules::Enum.max([1, 2, 3]) # => 3
      #   F::Modules::Enum.max([]) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Enum.max
      #   curried.([1, 2, 3]) # => 3
      #   curried.([]) # => nil
      def max(enumerable = F._)
        curry_implementation(:max, enumerable)
      end

      private

      def _max(enumerable)
        _enum(enumerable).max
      end
    end
  end
end
