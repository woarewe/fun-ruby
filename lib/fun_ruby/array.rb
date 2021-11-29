# frozen_string_literal: true

require_relative "common/helpers"

module FunRuby
  # Module containing methods for arrays
  module Array
    include Common::Helpers

    extend self

    # Returns a size of array
    #
    # @since 0.1.0
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
    def size(array = F._)
      curry_implementation(:size, array)
    end

    # Returns a string built from elements joined by a given string
    #
    # @since 0.1.0
    #
    # @param string [String]
    # @param array [::Array]
    #
    # @return [String]
    #
    # @example Basics
    #   ary = [1, 2, 3]
    #   F::Array.join("+", ary) # => "1+2+3"
    def join(string = F._, array = F._)
      curry_implementation(:join, string, array)
    end

    private

    def _size(array)
      _array(array).size
    end

    def _join(string, array)
      _array(array).join(string)
    end

    def _array(array)
      array.to_a
    end
  end
end
