# frozen_string_literal: true

require_relative "core"

module FunRuby
  # Module containing methods for arrays
  module Array
    include Core

    extend self

    # Returns a size of array
    #
    # @param array [::Array]
    #
    # @return [Integer]
    #
    # @example Basics
    #   F::Array.size([]) # => 0
    #   F::Array.size([1]) # => 1
    #   F::Array.size([1, 2, 3]) # => 3
    #
    # @example Curried
    #   curried = F::Array.size
    #   curried.([1,2,3]) # => 3
    #   curried.([]) # => 0
    def size(array = _)
      curried(:size, array)
    end

    private

    def _size(array)
      _array(array).size
    end

    def _array(array)
      array.to_a
    end
  end
end
