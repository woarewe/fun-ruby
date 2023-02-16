# frozen_string_literal: true

module FunRuby
  module Modules
    # @private
    module Enum
      # Returns the maximum element of the enumerable
      #
      # @since 0.1.0
      #
      # @param function [#call/1] ->(left, right) { returns Boolean }
      # @param enumerable [#to_enum]
      #
      # @return [Object]
      #
      # @example Basics
      #   F::Modules::Enum.max(->(first, second) { first <=> second }, [1, 2, 3]) # => 3
      #   F::Modules::Enum.max(->(first, second) { first <=> second }, [1, 2, 3]) #=> 3
      #   F::Modules::Enum.max(->(first, second) { first <=> second }, []) # => nil
      #
      # @example Curried
      #   curried = F::Modules::Enum.max(->(first, second) { first <=> second })
      #   curried.([1, 2, 3]) # => 3
      #   curried.([]) # => nil
      def max(function = F._, enumerable = F._)
        curry_implementation(:max, function, enumerable)
      end

      private

      def _max(function, enumerable)
        _enum(enumerable).max(&function)
      end
    end
  end
end
