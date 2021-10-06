# frozen_string_literal: true

require_relative "core"

module FunRuby
  module Enum
    include Core

    extend self

    def all?(function = _, enumerable = _)
      curried(:all?, function, enumerable)
    end

    def any?(function = _, enumerable = _)
      curried(:any?, function, enumerable)
    end

    def chain(enumerable = _, *enumerables)
      curried(:chain, enumerable, *enumerables)
    end

    def chunk(function = _, enumerable = _)
      curried(:chunk, function, enumerable)
    end

    def chunk_while(function = _, enumerable = _)
      curried(:chunk_while, function, enumerable)
    end

    def count_by(function = _, enumerable = _)
      curried(:count_by, function, enumerable)
    end

    def take(amount = _, enumerable = _)
      curried(:take, amount, enumerable)
    end

    # Applies a function to each element of an enumerable and
    # returns the initial enumerable
    #
    # @param function [#call/1]
    # @param enumerable [#to_enum]
    #
    # @return [::Array] the passed enumerable
    #
    # @example Basic
    #   F::Enum.each(->(x) { puts x }, [1, 2, 3]) #=> [1, 2, 3]
    #
    # @example Curried
    #   curried = F::Enum.each
    #   curried.(->(x) { puts x }).([1, 2, 3]) #=> [1, 2, 3]
    #
    # @example Curried with placeholder
    #   curried = F::Enum.each(F._, [1, 2, 3])
    #   curried.(->(x) { puts x }) #=> [1, 2, 3]
    def each(function = _, enumerable = _)
      curried(:each, function, enumerable)
    end

    # Returns a new enumerable with new values calculated
    # by applying a function to each element of a passed enumerable
    #
    # @param function [#call/1]
    # @param enumerable [#to_enum]
    #
    # @return [::Array] a new enumerable with calculated values
    #
    # @example Basic
    #   F::Enum.map(->(x) { x * 2 }, [1, 2, 3]) #=> [2, 4, 6]
    #
    # @example Curried
    #   curried = F::Enum.map
    #   curried.(->(x) { x * 2 }).([1, 2, 3]) #=> [2, 4, 6]
    #
    # @example Curried with placeholder
    #   curried = F::Enum.map(F._, [1, 2, 3])
    #   curried.(->(x) { x * 2 }) # => [2, 4, 6]
    def map(function = _, enumerable = _)
      curried(:map, function, enumerable)
    end

    # Returns a new enumerable containing only these elements
    # results of calling a function on them are truthy
    #
    # @param function [#call/1]
    # @param enumerable [#to_enum]
    #
    # @return [::Array] a new enumerable with selected values
    #
    # @example Basic
    #   F::Enum.select(->(x) { x % 2 == 0 }, [1, 2, 3, 4, 5]) #=> [2, 4]
    #
    # @example Curried
    #   curried = F::Enum.select
    #   curried.(->(x) { x % 2 == 0 }).( [1, 2, 3, 4, 5]) #=> [2, 4]
    #
    # @example Curried with placeholder
    #   curried = F::Enum.select(F._, [1, 2, 3, 4, 5])
    #   curried.(->(x) { x % 2 == 0 }) #=> [2, 4]
    def select(function = _, enumerable = _)
      curried(:select, function, enumerable)
    end

    private

    # @private
    def _all?(function, enumerable)
      _enum(enumerable).all?(&function)
    end

    # @private
    def _any?(function, enumerable)
      _enum(enumerable).any?(&function)
    end

    # @private
    def _chain(enumerable, *enumerables)
      _enum(enumerable).chain(*enumerables)
    end

    # @private
    def _chunk(function, enumerable)
      _enum(enumerable).chunk(&function)
    end

    # @private
    def _chunk_while(function, enumerable)
      _enum(enumerable).chunk_while(&function)
    end

    # @private
    def _count_by(function, enumerable)
      _enum(enumerable).count(&function)
    end

    # @private
    def _take(amount, enumerable)
      _enum(enumerable).take(amount)
    end

    # @private
    def _each(function, enumerable)
      _enum(enumerable).each(&function)
    end

    # @private
    def _map(function, enumerable)
      _enum(enumerable).map(&function)
    end

    # @private
    def _select(function, enumerable)
      _enum(enumerable).select(&function)
    end

    # @private
    def _enum(enumerable)
      enumerable.to_enum
    end
  end
end
