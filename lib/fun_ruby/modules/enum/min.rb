# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Enum
      # Returns the minimum element of the enumerable
      #
      # @since 0.1.0
      #
      # @param function [#call/1] ->(left, right) { returns Boolean }
      # @param enumerable [#to_enum]
      #
      # @return [Object]
      #
      # @example Basics
      #   F::Modules::Enum.min(->(first, second) { first <=> second }, [1, 2, 3]) # => 1
      #   F::Modules::Enum.min(->(first, second) { first <=> second }, [1, 2, 3]) #=> 1
      #   F::Modules::Enum.min(->(first, second) { first <=> second }, []) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Enum.min(->(first, second) { first <=> second })
      #   curried.([1, 2, 3]) # => 1
      #   curried.([]) # => nil
      def min(function = F._, enumerable = F._)
        curry_implementation(:min, function, enumerable)
      end

      private

      def _min(function, enumerable)
        _enum(enumerable).min(&function)
      end
    end
  end
end
