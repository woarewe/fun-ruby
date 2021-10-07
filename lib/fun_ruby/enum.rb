# frozen_string_literal: true

require_relative "core"

module FunRuby
  # Module containing methods for enumerables
  module Enum
    include Core

    extend self

    # Returns a boolean which represents if all results
    # of applying a function to each element are truthy
    #
    # @since 0.1.0
    #
    # @param function [#call/1]
    # @param enumerable [#to_enum]
    #
    # @return [Boolean]
    #
    # @example Basic returning true
    #   F::Enum.all?(->(x) { x % 2 == 0 }, [2, 4, 6]) #=> true
    #
    # @example Basic returning false
    #   F::Enum.all?(->(x) { x % 2 == 0 }, [2, 5, 6]) #=> false
    #
    # @example Curried
    #   curried = F::Enum.all?
    #   curried.(->(x) { x % 2 == 0 }).([1, 2, 3]) #=> false
    #
    # @example Curried with placeholder
    #   curried = F::Enum.all?(F._, [2, 4, 6])
    #   curried.(->(x) { x % 2 == 0 }) # => true
    def all?(function = _, enumerable = _)
      curried(:all?, function, enumerable)
    end

    # Applies a function to each element of an enumerable and
    # returns the initial enumerable
    #
    # @since 0.1.0
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
    # @since 0.1.0
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
    # @since 0.1.0
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

    # Returns a single item by iterating through the list, successively
    # calling the iterator function and passing it an accumulator value
    # and the current value from the array, and then passing the result
    # to the next call.
    #
    # @since 0.1.0
    #
    # @param function [#call/2] ->(accumulator, element) {}
    # @param accumulator Object
    # @param enumerable [#to_enum]
    #
    # @return Object a result of reducing the enumerable
    #
    # @example Basic: sum of all elements
    #   F::Enum.reduce(->(acc, x) { acc + x }, 0, [1, 2, 3]) #=> 6
    #
    # @example Basic: subtraction of all elements
    #   F::Enum.reduce(->(acc, x) { acc - x }, 0, [1, 2, 3]) #=> -6
    #
    # @example Basic: histogram
    #   F::Enum.reduce(
    #     ->(acc, x) { acc[x] += 1; acc },
    #     Hash.new(0),
    #     [1, 1, 1, 2, 2, 3]
    #   ) #=> { 1 => 3, 2 => 2, 3 => 1 }
    #
    # @example Curried: sum
    #   curried = F::Enum.reduce
    #   curried.(->(acc, x) { acc + x }).(0).([1, 2, 3]) #=> 6
    #
    # @example Curried: sum with placeholder for function
    #   curried = F::Enum.reduce(F._, 0, [1, 2, 3])
    #   curried.(->(acc, x) { acc + x }) #=> 6
    #
    # @example Curried: sum with placeholder for accumulator
    #   curried = F::Enum.reduce(->(acc, x) { acc + x }, F._, [1, 2, 3])
    #   curried.(0) #=> 6
    #
    # @example Curried: sum with placeholder for function and accumulator
    #   curried = F::Enum.reduce(F._, F._, [1, 2, 3])
    #   curried.(->(acc, x) { acc + x }, 0) # => 6
    #   curried.(->(acc, x) { acc + x }).(0) # => 6
    def reduce(function = _, accumulator = _, enumerable = _)
      curried(:reduce, function, accumulator, enumerable)
    end

    private

    def _all?(function, enumerable)
      _enum(enumerable).all?(&function)
    end

    def _each(function, enumerable)
      _enum(enumerable).each(&function)
    end

    def _map(function, enumerable)
      _enum(enumerable).map(&function)
    end

    def _select(function, enumerable)
      _enum(enumerable).select(&function)
    end

    def _reduce(function, accumulator, enumerable)
      _enum(enumerable).reduce(accumulator, &function)
    end

    def _enum(enumerable)
      enumerable.to_enum
    end
  end
end
