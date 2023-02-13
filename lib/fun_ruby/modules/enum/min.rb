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
      #   F::Modules::Enum.min([3, 2, 1]) # => 1
      #   F::Modules::Enum.min([]) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Enum.min
      #   curried.([3, 2, 1]) # => 1
      #   curried.([]) # => nil
      def min(enumerable = F._)
        curry_implementation(:min, enumerable)
      end

      private

      def _min(enumerable)
        _enum(enumerable).min
      end
    end
  end
end
